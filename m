Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4BFFC43
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 00:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfKQX2s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 17 Nov 2019 18:28:48 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:35151 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKQX2s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Nov 2019 18:28:48 -0500
Received: by mail-io1-f68.google.com with SMTP id x21so16679588ior.2
        for <linux-pci@vger.kernel.org>; Sun, 17 Nov 2019 15:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLrDRkj2zG6C0Hi1gLXOXE5rXliBuMxaQzf1Hg9z/Qg=;
        b=gYh+9VSU3l4JVqt7hplEMsElL8VkPwE3YKqeud/6Qamz54Bqa5bUEI2hdqqRj1+0qD
         mgizE4qAgP4QiuDnYFZY9+LhcvZ9fQHAhELmwhPhT389qflgg6KEQnPvA+vOyssJ2286
         pRWjtD1ccCNpG1WdvVtJXVeRAynl5jARO0KnwDv6axkO5RjjIGKkBF/78E7PneIH8Oxy
         XyH6+MEcDXY/ZPOv9DsUM5ln9kqpUbZ6b0FkU8X3aPuH5V0ykBqIvGxrKSwfugItXmvi
         xZDVrpCj87Z3ERq3F21ApStSI0d0hxWokdEEjsUlefXLRrFp2gpyuvNLmGCPux38jQF+
         5r3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLrDRkj2zG6C0Hi1gLXOXE5rXliBuMxaQzf1Hg9z/Qg=;
        b=Vsz9eymr7XvtuhG5JUxcentGL2lRAJdRue492mFq3PywD7KTtNcj6SEm/jLbJfCank
         h2DfWIoJrmDiUzfShEWAnH31TfeInT+m7Fi8qLcUhmsCJDgch7q52GB3PoZ6N0zcP7DO
         REYevSWv4xXOtsjb8Wm6JqlheBf88OCeT5Uhq6Xu22ROGacGC2JTNiiYFwsvkz/tkHCq
         Rt2cz2ceVgZ1Ng2WBWknMPgv7aTizX5dYnWf9hI5S6rdrfcgjD/hqo4yqHjNxeIlirEX
         OszBvVQjkZX1esSmXpjJEJWGpyh2mppfFE+XtUq/uctBlSyJnk7dBVZ0QwwSjmlojMV6
         k0Rw==
X-Gm-Message-State: APjAAAUaar2JhwoPJgumsUVmhxoiuse2mw3mjESnqmNIjhfv+ezRDEbR
        /r74Whewv3a55yXb4vHvyrm56bwTz0iBatxQtHiExg==
X-Google-Smtp-Source: APXvYqzpqpV/4wk9F64EmqSB5Knnpyja9CawKMd0nXjt3UO7TlbEl5CavOvhLgfrJdEPXEaJeuEMVKb9CTly8s0UZFM=
X-Received: by 2002:a02:a38f:: with SMTP id y15mr10835809jak.101.1574033326865;
 Sun, 17 Nov 2019 15:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20190926112933.8922-1-kishon@ti.com> <20190926112933.8922-6-kishon@ti.com>
In-Reply-To: <20190926112933.8922-6-kishon@ti.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Sun, 17 Nov 2019 18:28:36 -0500
Message-ID: <CAPoiz9yRemT5Q4FYCgx-mmkhywG2TP_OUU_tfLGWJXfO6KRwDA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/21] PCI: endpoint: Add API to get reference to EPC
 from device-tree
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-ntb <linux-ntb@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 26, 2019 at 7:31 AM 'Kishon Vijay Abraham I' via linux-ntb
<linux-ntb@googlegroups.com> wrote:
>
> Add of_pci_epc_get() and of_pci_epc_get_by_name() to get reference
> to EPC from device-tree. This is added in preparation to define
> an endpoint function from device tree.

I can't get this patch to apply cleanly to my git tree (for the
current or any of the previous kernels I tried).  Please rebase this
series when you send it out as a patch.

Thanks,
Jon


> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 61 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             |  4 +-
>  2 files changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 5bc094093a47..0c2fdd39090c 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -83,6 +83,66 @@ struct pci_epc *pci_epc_get(const char *epc_name)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get);
>
> +/**
> + * of_pci_epc_get() - get PCI endpoint controller from device node and index
> + * @node: device node which contains the phandle to endpoint controller
> + * @index: index of the endpoint controller in "epcs" property
> + *
> + * Returns the EPC corresponding to the _index_ entry in "epcs" property
> + * present in device node, after getting a refcount  to it or -ENODEV if
> + * there is no such EPC or -EPROBE_DEFER if there is a phandle to the phy,
> + * but the device is not yet loaded.
> + */
> +struct pci_epc *of_pci_epc_get(struct device_node *node, int index)
> +{
> +       struct device_node *epc_node;
> +       struct class_dev_iter iter;
> +       struct pci_epc *epc;
> +       struct device *dev;
> +
> +       epc_node = of_parse_phandle(node, "epcs", index);
> +       if (!epc_node)
> +               return ERR_PTR(-ENODEV);
> +
> +       class_dev_iter_init(&iter, pci_epc_class, NULL, NULL);
> +       while ((dev = class_dev_iter_next(&iter))) {
> +               epc = to_pci_epc(dev);
> +               if (epc_node != epc->dev.of_node)
> +                       continue;
> +
> +               of_node_put(epc_node);
> +               class_dev_iter_exit(&iter);
> +               get_device(&epc->dev);
> +               return epc;
> +       }
> +
> +       of_node_put(node);
> +       class_dev_iter_exit(&iter);
> +       return ERR_PTR(-EPROBE_DEFER);
> +}
> +EXPORT_SYMBOL_GPL(of_pci_epc_get);
> +
> +/**
> + * of_pci_epc_get_by_name() - get PCI endpoint controller from device node
> + *                            and string
> + * @node: device node which contains the phandle to endpoint controller
> + * @epc_name: name of endpoint controller as present in "epc-names" property
> + *
> + * Returns the EPC corresponding to the epc_name in "epc-names" property
> + * present in device node.
> + */
> +struct pci_epc *of_pci_epc_get_by_name(struct device_node *node,
> +                                      const char *epc_name)
> +{
> +       int index = 0;
> +
> +       if (epc_name)
> +               index = of_property_match_string(node, "epc-names", epc_name);
> +
> +       return of_pci_epc_get(node, index);
> +}
> +EXPORT_SYMBOL_GPL(of_pci_epc_get_by_name);
> +
>  /**
>   * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
>   * @epc_features: pci_epc_features structure that holds the reserved bar bitmap
> @@ -661,6 +721,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
>         device_initialize(&epc->dev);
>         epc->dev.class = pci_epc_class;
>         epc->dev.parent = dev;
> +       epc->dev.of_node = dev->of_node;
>         epc->ops = ops;
>
>         ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 0fff52675a6b..ef6531af6ed2 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -202,7 +202,9 @@ unsigned int pci_epc_get_first_free_bar(const struct pci_epc_features
>                                         *epc_features);
>  struct pci_epc *pci_epc_get(const char *epc_name);
>  void pci_epc_put(struct pci_epc *epc);
> -
> +struct pci_epc *of_pci_epc_get(struct device_node *node, int index);
> +struct pci_epc *of_pci_epc_get_by_name(struct device_node *node,
> +                                      const char *epc_name);
>  int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_addr, size_t size,
>                        size_t page_size);
>  void pci_epc_mem_exit(struct pci_epc *epc);
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20190926112933.8922-6-kishon%40ti.com.
