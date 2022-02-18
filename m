Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2474BC182
	for <lists+linux-pci@lfdr.de>; Fri, 18 Feb 2022 22:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiBRVEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 16:04:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbiBRVEh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 16:04:37 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BD728B61C
        for <linux-pci@vger.kernel.org>; Fri, 18 Feb 2022 13:04:19 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id h7-20020a17090a648700b001b927560c2bso9656196pjj.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Feb 2022 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMO1EvM45tZ9gPAGgbTMhxxww5OQtGLRxM/YY6GDTCw=;
        b=kiT4jvqhWhoNe17tPInhsmocLq5jIyGXe+w/I6GK5bbsveF1KwaEaonN1D5f9A/hmo
         NaDXZbw0wDYXK+K0A6MaKw99I92SaEaMdYr7umPuMTZpYJBo2VeUJ08cgcthEe8FX0Qy
         ofifQRC72nlxcl2BcnW5ZOELGEOTHyu90XydqR9lXVv4Dm1SfEpUffHbUOSHA9hyGsHC
         R3sDwtn17I87D8FqRnYuQUiwaWeyQceBfY+McQ/izqds/N3pWSZTKKclBpTZwBRGwfh6
         r6gnwjFq+vazBdsBfAE2LwTGmcndJSToRs+XbQ1gKYrKYdzWB4GUDNM2bKTugZuCiByd
         i0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMO1EvM45tZ9gPAGgbTMhxxww5OQtGLRxM/YY6GDTCw=;
        b=Oll1X9myaq4qLNT/zTDJFtRn9szHYaUUOGiW7lo+/LP4JAH6w/fTPR3Pa1mw0cuJlk
         Jd3ZLgMfPpdOE5lMKdsNGQkqOBBjbASB/UQaUMPt8jvPoRCW5ulwo3Qk/UP18mjNbVeT
         JwLVor8X5zH5TCwlWf9aMTXLBp7SNHdRtrYBcm4WCAv0S3w+eKAOGwiLY6yaq63g5Ozs
         Sd8eC70/TRh34aa/Ygx+mywXl7QP17a1buWjTPI2b0eeQycyjq8Iywu23RtWjMYrFm/E
         tDHXKBo0YYPtgQzapj8MFnLNfcMj9ONJEJm/c9x3KDcB2QULdQQKbOPxFMw6O7hFt177
         C+bA==
X-Gm-Message-State: AOAM5332EfTnIt9u/3g+lgErVBOlFfs9GW06UCRno2P100NF1/5eIku6
        qA3voBikzX2HqRUfQx3SGDD0VaYZ2M4ZvMIUyJdzYg==
X-Google-Smtp-Source: ABdhPJzyOMZ1rxsMJNB4KrvCnT155JuOBp4wWD9jJ/AhkkSOkgVKHtudm2CyxsrH/2Z/qKGwhLOzB/B+n4LtvxwbxTI=
X-Received: by 2002:a17:90b:1a92:b0:1b9:8094:446b with SMTP id
 ng18-20020a17090b1a9200b001b98094446bmr9933721pjb.93.1645218258676; Fri, 18
 Feb 2022 13:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com> <20220128002707.391076-9-ben.widawsky@intel.com>
In-Reply-To: <20220128002707.391076-9-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Feb 2022 13:04:07 -0800
Message-ID: <CAPcyv4i68KM52wXbeO_y9VHpbD_KQN1oZSZmps8dYYMuNYUc6w@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] cxl/region: HB port config verification
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Host bridge root port verification determines if the device ordering in
> an interleave set can be programmed through the host bridges and
> switches.
>
> The algorithm implemented here is based on the CXL Type 3 Memory Device
> Software Guide, chapter 2.13.15. The current version of the guide does
> not yet support x3 interleave configurations, and so that's not
> supported here either.

Given x3 is in a released ECN lets go ahead and include it because it
may have a material effect on the design, but more importantly the
ABI.

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  .clang-format           |   1 +
>  drivers/cxl/core/port.c |   1 +
>  drivers/cxl/cxl.h       |   2 +
>  drivers/cxl/region.c    | 127 +++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 130 insertions(+), 1 deletion(-)
>
> diff --git a/.clang-format b/.clang-format
> index 1221d53be90b..5e20206f905e 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -171,6 +171,7 @@ ForEachMacros:
>    - 'for_each_cpu_wrap'
>    - 'for_each_cxl_decoder_target'
>    - 'for_each_cxl_endpoint'
> +  - 'for_each_cxl_endpoint_hb'
>    - 'for_each_dapm_widgets'
>    - 'for_each_dev_addr'
>    - 'for_each_dev_scope'
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0847e6ce19ef..1d81c5f56a3e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -706,6 +706,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>                 return ERR_PTR(-ENOMEM);
>
>         INIT_LIST_HEAD(&dport->list);
> +       INIT_LIST_HEAD(&dport->verify_link);
>         dport->dport = dport_dev;
>         dport->port_id = port_id;
>         dport->component_reg_phys = component_reg_phys;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a291999431c7..ed984465b59c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -350,6 +350,7 @@ struct cxl_port {
>   * @component_reg_phys: downstream port component registers
>   * @port: reference to cxl_port that contains this downstream port
>   * @list: node for a cxl_port's list of cxl_dport instances
> + * @verify_link: node used for hb root port verification
>   */
>  struct cxl_dport {
>         struct device *dport;
> @@ -357,6 +358,7 @@ struct cxl_dport {
>         resource_size_t component_reg_phys;
>         struct cxl_port *port;
>         struct list_head list;
> +       struct list_head verify_link;

Is this list also protected by the port device_lock?

>  };
>
>  /**
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index 562c8720da56..d2f6c990c8a8 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -4,6 +4,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/sort.h>
>  #include <linux/pci.h>
>  #include "cxlmem.h"
>  #include "region.h"
> @@ -36,6 +37,12 @@
>         for (idx = 0, ep = (region)->config.targets[idx];                      \
>              idx < region_ways(region); ep = (region)->config.targets[++idx])
>
> +#define for_each_cxl_endpoint_hb(ep, region, hb, idx)                          \
> +       for (idx = 0, (ep) = (region)->config.targets[idx];                    \
> +            idx < region_ways(region);                                        \
> +            idx++, (ep) = (region)->config.targets[idx])                      \
> +               if (get_hostbridge(ep) == (hb))
> +
>  #define for_each_cxl_decoder_target(dport, decoder, idx)                       \
>         for (idx = 0, dport = (decoder)->target[idx];                          \
>              idx < (decoder)->nr_targets - 1;                                  \
> @@ -299,6 +306,59 @@ static bool region_xhb_config_valid(const struct cxl_region *cxlr,
>         return true;
>  }
>
> +static struct cxl_dport *get_rp(struct cxl_memdev *ep)
> +{
> +       struct cxl_port *port, *parent_port = port = ep->port;
> +       struct cxl_dport *dport;
> +
> +       while (!is_cxl_root(port)) {
> +               parent_port = to_cxl_port(port->dev.parent);
> +               if (parent_port->depth == 1)
> +                       list_for_each_entry(dport, &parent_port->dports, list)

Locking?

> +                               if (dport->dport == port->uport->parent->parent)

This assumes no switches.

Effectively it is identical to what devm_cxl_enumerate_ports(), which
does support switches, is doing. To reduce maintenance burden it could
follow the same pattern of:

for (iter = dev; iter; iter = grandparent(iter))
...
if (dev_is_cxl_root_child(&port->dev))
...

> +                                       return dport;
> +               port = parent_port;
> +       }
> +
> +       BUG();

more kernel crashing... why?

> +       return NULL;
> +}
> +
> +static int get_num_root_ports(const struct cxl_region *cxlr)
> +{
> +       struct cxl_memdev *endpoint;
> +       struct cxl_dport *dport, *tmp;
> +       int num_root_ports = 0;
> +       LIST_HEAD(root_ports);
> +       int idx;
> +
> +       for_each_cxl_endpoint(endpoint, cxlr, idx) {
> +               struct cxl_dport *root_port = get_rp(endpoint);
> +
> +               if (list_empty(&root_port->verify_link)) {
> +                       list_add_tail(&root_port->verify_link, &root_ports);

Doesn't this run into problems when there are multiple regions per root port?

> +                       num_root_ports++;
> +               }
> +       }
> +
> +       list_for_each_entry_safe(dport, tmp, &root_ports, verify_link)
> +               list_del_init(&dport->verify_link);
> +
> +       return num_root_ports;
> +}
> +
> +static bool has_switch(const struct cxl_region *cxlr)
> +{
> +       struct cxl_memdev *ep;
> +       int i;
> +
> +       for_each_cxl_endpoint(ep, cxlr, i)
> +               if (ep->port->depth > 2)
> +                       return true;
> +
> +       return false;
> +}
> +
>  /**
>   * region_hb_rp_config_valid() - determine root port ordering is correct
>   * @cxlr: Region to validate
> @@ -312,7 +372,72 @@ static bool region_xhb_config_valid(const struct cxl_region *cxlr,
>  static bool region_hb_rp_config_valid(const struct cxl_region *cxlr,
>                                       const struct cxl_decoder *rootd)
>  {
> -       /* TODO: */
> +       const int num_root_ports = get_num_root_ports(cxlr);
> +       struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];

In terms of stack usage, doesn't the caller also have one of these on
the stack when this is called?

> +       int hb_count, i;
> +
> +       hb_count = get_unique_hostbridges(cxlr, hbs);
> +
> +       /* TODO: Switch support */
> +       if (has_switch(cxlr))
> +               return false;
> +
> +       /*
> +        * Are all devices in this region on the same CXL Host Bridge
> +        * Root Port?
> +        */
> +       if (num_root_ports == 1 && !has_switch(cxlr))
> +               return true;

How can this happen without any intervening switch?

> +
> +       for (i = 0; i < hb_count; i++) {
> +               int idx, position_mask;
> +               struct cxl_dport *rp;
> +               struct cxl_port *hb;
> +
> +               /* Get next CXL Host Bridge this region spans */
> +               hb = hbs[i];
> +
> +               /*
> +                * Calculate the position mask: NumRootPorts = 2^PositionMask
> +                * for this region.
> +                *
> +                * XXX: pos_mask is actually (1 << PositionMask)  - 1
> +                */
> +               position_mask = (1 << (ilog2(num_root_ports))) - 1;

Isn't "1 << ilog2(num_root_ports)" just "num_root_ports"?

> +
> +               /*
> +                * Calculate the PortGrouping for each device on this CXL Host
> +                * Bridge Root Port:
> +                * PortGrouping = RegionLabel.Position & PositionMask

Still confused what a port grouping is and what it means for the
algorithm especially since RegionLabels are not relevant to this part
of the algorithm. This assumes someone is familiar with "guide"
terminology?

> +                *
> +                * The following nest iterators effectively iterate over each
> +                * root port in the region.
> +                *   for_each_unique_rootport(rp, cxlr)
> +                */
> +               list_for_each_entry(rp, &hb->dports, list) {
> +                       struct cxl_memdev *ep;
> +                       int port_grouping = -1;
> +
> +                       for_each_cxl_endpoint_hb(ep, cxlr, hb, idx) {
> +                               if (get_rp(ep) != rp)
> +                                       continue;
> +
> +                               if (port_grouping == -1)
> +                                       port_grouping = idx & position_mask;
> +
> +                               /*
> +                                * Do all devices in the region connected to this CXL
> +                                * Host Bridge Root Port have the same PortGrouping?
> +                                */
> +                               if ((idx & position_mask) != port_grouping) {
> +                                       dev_dbg(&cxlr->dev,
> +                                               "One or more devices are not connected to the correct Host Bridge Root Port\n");
> +                                       return false;
> +                               }
> +                       }
> +               }
> +       }
> +
>         return true;
>  }
>
> --
> 2.35.0
>
