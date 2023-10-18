Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A87CDA08
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjJRLMA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 07:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjJRLL7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 07:11:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE87CFE;
        Wed, 18 Oct 2023 04:11:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so80900391fa.3;
        Wed, 18 Oct 2023 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697627516; x=1698232316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQFBBHEStuhkSBdtrViUBG2kf2BEuRZkv42uXZ713vk=;
        b=BxpgTcG3wIxOyBMl3TwUAVS/tKXtN24+GgbGZfTpmDk8+5tVDwzvzkoLbvqjLQMs7B
         srWUmw3QQwYVaDokt4WwkJ0IgRr99IKKHZ+RBMI/gzIi/NqfstIqJzHoUyAAx1bNS76O
         +/g5hZ0wzkLceDVlWFr8IOX8TcQ5NEt06HWswFz/a99h60o4NK5AOolQRCAr/Iavom8h
         TqVy7jAZvnSjGwQrT/2ap1a1T23i4Gl8SDTkE5O7dDpIGw/tk9k9tgK9DJYs/lE9Zv/N
         oAWCyMHNRvJeYZtJy2bvV1b3JL3gPN74ucHmSiCv7ODwOL/jCWVZm94LtzWdB2RVXRyJ
         ENJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697627516; x=1698232316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQFBBHEStuhkSBdtrViUBG2kf2BEuRZkv42uXZ713vk=;
        b=n2Pa9yxIX5ou2xgqBGyTGaeCDrZP2CyaGOzMPRHx6ZUx35tUZmRHmYx3F3Kb1jNvJB
         Us9yBy9i4ocfIxsISnH+Cw8kGlfsfOFYMnxp29N5YWb2H9CpjHuHCCnORQjnovlA3xOD
         p0cup9dj1Zd/vZFuJ01ZzjRq/hBnYzqF3poy43gRtnq9J9YXJgHK7yzhxa75/TzqzwzU
         3zRm/JFPC7d5Zrmeb48ZyEC2rFetXTqT71b0nu3votuPhc7uzcx9+qG6lfzNa5ak/vDl
         0JtKiUXW26meLA+k1w5ymmzyPSEc3Rj+/WZANWkM5U8Sx6ODiz5SNMG/Kvvdc+cdAFR9
         BR8Q==
X-Gm-Message-State: AOJu0YzFzRVkSAnkCHyFyB+nW2C6hklIzpSi8JoO02eDR5iEpLeesmBa
        AY/BZCwBskq4/06rFWyVHPQ=
X-Google-Smtp-Source: AGHT+IGE8kwPLL9OJEhJhKC57slqm/XHaN6b3Dv4R2zIGxbA4QnFhaq9FCUfHLrmBEbn/CQ4gXd37Q==
X-Received: by 2002:a2e:9bd7:0:b0:2ba:6519:c50f with SMTP id w23-20020a2e9bd7000000b002ba6519c50fmr3529599ljj.52.1697627515673;
        Wed, 18 Oct 2023 04:11:55 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k23-20020a2e8897000000b002b9ef00b10csm668296lji.2.2023.10.18.04.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 04:11:55 -0700 (PDT)
Date:   Wed, 18 Oct 2023 14:11:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        r-gunasekaran@ti.com, srk@ti.com
Subject: Re: [PATCH v2] PCI: keystone: Fix ks_pcie_v3_65_add_bus() for AM654x
 SoC
Message-ID: <zje5t7zbaisyzwgvkdxnqwlcadsyegipxbhsxxpbqlnuu45ria@4sqxpgieoig2>
References: <20231018075038.2740534-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018075038.2740534-1-s-vadapalli@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 18, 2023 at 01:20:38PM +0530, Siddharth Vadapalli wrote:
> The ks_pcie_v3_65_add_bus() member of "ks_pcie_ops" was added for
> platforms using DW PCIe IP-core version 3.65a. The AM654x SoC uses
> DW PCIe IP-core version 4.90a and ks_pcie_v3_65_add_bus() is not
> applicable to it.

I'll copy my message from v1 regarding the IP-core version. Are you
really sure that it's 4.90a? Here is what my DW PCIe RC
_v4.90_ HW databook says about the BARs:

"Base Address Registers (Offset: 0x10-x14) The Synopsys core does not
implement the optional BARs for the RC product. This is based on the
assumption that the RC host probably has registers on some other
internal bus and has knowledge and setup access to these registers
already."

You cited the next text:

"3.5.7.2 RC Mode. Two BARs are present but are not expected to be
used. You should disable them or else they will be unnecessarily
assigned memory during device enumeration. If you do use a BAR, then
you should program it to capture TLPs that are targeted to your local
non-application memory space residing on TRGT1, and not for the
application on TRGT1. The BAR range must be outside of the three
Base/Limit regions."

AFAICS from the v5.20a, v5.30a, v5.40a databooks, it resides in the
_v5.x_ databooks only meanwhile the older ones (v4.21, v4.60a, v4.70a
and _v4.90a_) describe the BARs as I cited earlier. It makes my
thinking that in your case the IP-core isn't of 4.90a version. Could
you please clarify how did you detect the version? Did you use the
PCIE_VERSION_NUMBER_OFF register available in the PORT_LOGIC CSRs
space? If your judgment was based on the Keyston PCIe driver code,
then the driver might get to be wrong in that matter.

> 
> The commit which added support for the AM654x SoC has reused majority
> of the functions with the help of the "is_am6" flag to handle AM654x
> separately where applicable. Thus, make use of the "is_am6" flag and
> change ks_pcie_v3_65_add_bus() to no-op for AM654x SoC.
> 
> Fixes: 18b0415bc802 ("PCI: keystone: Add support for PCIe RC in AM654x Platforms")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Hello,
> 
> This patch is based on linux-next tagged next-20231018.
> 
> The v1 of this patch is at:
> https://lore.kernel.org/r/20231011123451.34827-1-s-vadapalli@ti.com/
> 
> While there are a lot of changes since v1 and this patch could have been
> posted as a v1 patch itself, I decided to post it as the v2 of the patch
> mentioned above since it aims to address the issue described by the v1
> patch and is similar in that sense. However, the solution to the issue
> described in the v1 patch appears to be completely different from what
> was implemented in the v1 patch. Thus, the commit message and subject of
> this patch have been modified accordingly.
> 
> Changes since v1:
> - Updated patch subject and commit message.
> - Determined that issue is not with the absence of Link as mentioned in
>   v1 patch. Even with Link up and endpoint device connected, if
>   ks_pcie_v3_65_add_bus() is invoked and executed, all reads to the
>   MSI-X offsets return 0xffffffff when pcieport driver attempts to setup
>   AER and PME services. The all Fs return value indicates that the MSI-X
>   configuration is failing even if Endpoint device is connected. This is
>   because the ks_pcie_v3_65_add_bus() function is not applicable to the
>   AM654x SoC which uses DW PCIe IP-core version 4.90a.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 0def919f89fa..3abd59335574 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -459,7 +459,7 @@ static int ks_pcie_v3_65_add_bus(struct pci_bus *bus)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
>  

> -	if (!pci_is_root_bus(bus))
> +	if (!pci_is_root_bus(bus) || ks_pcie->is_am6)

1. IMO defining two versions of the pci_ops struct instances would look
more readable:
static struct pci_ops ks_pcie_v3_65_ops = {
        .map_bus = dw_pcie_own_conf_map_bus,
        .read = pci_generic_config_read,
        .write = pci_generic_config_write,
        .add_bus = ks_pcie_v3_65_add_bus,
};

static struct pci_ops ks_pcie_ops = {
        .map_bus = dw_pcie_own_conf_map_bus,
        .read = pci_generic_config_read,
        .write = pci_generic_config_write,
};

2. In case of 1. implemented, ks_pcie_ops will look the same as
ks_child_pcie_ops, so the later could be dropped.

3. I'm not that fluent in the PCIe core details, but based on the
pci_host_bridge.child_ops and pci_host_bridge.ops names, the first
ones will be utilized for the child PCIe buses, meanwhile the later
ones - for the root bus only (see pci_alloc_child_bus()). Bjorn?
If so then the pci_is_root_bus() check can be dropped from the
ks_pcie_v3_65_add_bus() method. After doing that I would have also
changed the name to ks_pcie_v3_65_add_root_bus(). In anyway I would
double-check the suggestion first.

-Serge(y)

>  		return 0;
>  
>  	/* Configure and set up BAR0 */
> -- 
> 2.34.1
> 
