Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507D32A8B88
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 01:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbgKFAkd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 19:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732577AbgKFAkd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 19:40:33 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E392C0613D2
        for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2020 16:40:33 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t18so1622268plo.0
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2020 16:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uCYBkE+TmCcUery/xnzfUl6aKRxtKvMXfGG8Ul87L8s=;
        b=NTdxuaouEl55lBJnkfWo3ASSBNl6ipyFrzlfttocTLWBERNI82YvP6k/kAOEVETPs/
         v8eUktb/ByC8hhuJsqwTrlqTqUH0YqC6808MScOQEeEC6lRA5X3kyBW/AefKpMdDft94
         ek0bD1QhTp+GWXF8R43Fz8vQMKQaCU7Dfrb9jfT+yiGHfBsSi2d36VI4g3XlH2w4tu+D
         beMxJjIYdYOuxrBdmwCKfMfmct9dwWIFT3AcESfRkQEPw+/NXEp7lrocziYZctGT35uX
         uzGmYi7vpX94kY5jvhS8+e+HT8tQsQNCMQ7ckyq4OnHHbwONC3nFSFdqVMmen6PlZ57n
         hLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uCYBkE+TmCcUery/xnzfUl6aKRxtKvMXfGG8Ul87L8s=;
        b=QYxd3L+I55K+u/PDc+uBPFa/LWz2GTLXwLBC8Z6llgCHSF3sxISkNgOVW2y6Dhmh/J
         CKGQjSyYfYqdCdJlQajIhyzH0SGhm/Bp23gf7yKy1QPV7vlfGLizBZiRoYXZ0/wGkC/3
         hBZfoyMaIEeEIpd/067LgYBskbhjdW6PZ04oXEUgPd82sbHa5BpO5S+48rQXWArYDC4u
         sXP5AFbba5nVCe4aKiAZvglsgIIqnz3u4AgnA2bOsqYb4I7CFncmGxuebFoFz79g0DmY
         HwSgGUNMLUDBy3Zdcg3SLdJRMTw8Cuo5eG/32Js3BTHkNQn+9IroAaf6BydwGzpwiju5
         Y2nA==
X-Gm-Message-State: AOAM531yDIQGrMZa8Lm0LMN0U9o8msUUesxdtF7UTU3OISqVn8UhRY/C
        NKM1di+ajszm/8D4tocwynnL8g==
X-Google-Smtp-Source: ABdhPJyJ2c++GjFYW2FsAr0qQqbbkRdAtQJW8TxSTJ/IrAF8beT1JVOI+kAi8KD8lveEQcD+Difygw==
X-Received: by 2002:a17:902:e993:b029:d6:41d8:9ca3 with SMTP id f19-20020a170902e993b02900d641d89ca3mr4766084plb.57.1604623233023;
        Thu, 05 Nov 2020 16:40:33 -0800 (PST)
Received: from [10.209.185.147] (fmdmzpr04-ext.fm.intel.com. [192.55.55.39])
        by smtp.gmail.com with ESMTPSA id gm12sm3613748pjb.28.2020.11.05.16.40.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 16:40:31 -0800 (PST)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Sean V Kelley" <sean.v.kelley@intel.com>
Subject: Re: [PATCH v10 13/16] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Thu, 05 Nov 2020 16:40:28 -0800
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <351325EE-9199-4E14-825A-75BA1678EFA1@intel.com>
In-Reply-To: <20201106001444.667232-14-sean.v.kelley@intel.com>
References: <20201106001444.667232-1-sean.v.kelley@intel.com>
 <20201106001444.667232-14-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5 Nov 2020, at 16:14, Sean V Kelley wrote:

> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>
> When attempting error recovery for an RCiEP associated with an RCEC =

> device,
> there needs to be a way to update the Root Error Status, the =

> Uncorrectable
> Error Status and the Uncorrectable Error Severity of the parent RCEC.  =

> In
> some non-native cases in which there is no OS-visible device =

> associated
> with the RCiEP, there is nothing to act upon as the firmware is acting
> before the OS.
>
> Add handling for the linked RCEC in AER/ERR while taking into account
> non-native cases.
>
> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Link: =

> https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@oregontr=
acks.org
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/pcie/aer.c | 35 +++++++++++++++++++++++++++--------
>  drivers/pci/pcie/err.c | 20 ++++++++++----------
>  2 files changed, 37 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4ab379fa1506..3498af81d240 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1357,29 +1357,48 @@ static int aer_probe(struct pcie_device *dev)
>   */
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  {
> +	int type =3D pci_pcie_type(dev);
>  	int aer =3D dev->aer_cap;
> +	struct pci_dev *root;
>  	int rc =3D 0;
>  	u32 reg32;
>
> +	if (type =3D=3D PCI_EXP_TYPE_RC_END)
> +		/*
> +		 * The reset should only clear the Root Error Status
> +		 * of the RCEC. Only perform this for the
> +		 * native case, i.e., an RCEC is present.
> +		 */
> +		root =3D dev->rcec;
> +	else
> +		root =3D dev;
> +
>  	if (pcie_aer_is_native(dev)) {
>  		/* Disable Root's interrupt in response to error messages */
> -		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>  		reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
> -		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
>  	}
>
> -	rc =3D pci_bus_error_reset(dev);
> -	pci_info(dev, "Root Port link has been reset (%d)\n", rc);
> +	if (type =3D=3D PCI_EXP_TYPE_RC_EC || type =3D=3D PCI_EXP_TYPE_RC_END=
) {
> +		if (pcie_has_flr(root)) {
> +			rc =3D pcie_flr(root);
> +			pci_info(dev, "has been reset (%d)\n", rc);
> +		}
> +	} else {
> +		rc =3D pci_bus_error_reset(root);
> +		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
> +	}

So this needs to change as I didn=E2=80=99t use the aer =3D dev->aer_cap =
from =

before
because I=E2=80=99m checking explicitly for pcie_aer_is_native().  Howeve=
r, we =

still
have the scenario of non-native and root =3D dev->rcec =3D NULL. Secondly=
, =

for the flr, that
should be happening on the dev and that should trump use of the root var =

anyway.

So I would change it to: (replacing root with dev)

  +	if (type =3D=3D PCI_EXP_TYPE_RC_EC || type =3D=3D PCI_EXP_TYPE_RC_END=
) {
  +		if (pcie_has_flr(dev)) {
  +			rc =3D pcie_flr(dev);
  +			pci_info(dev, "has been reset (%d)\n", rc);
  +		}
  +	} else {
  +		rc =3D pci_bus_error_reset(dev);
  +		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
  +	}

Thanks,

Sean


>
>  	if (pcie_aer_is_native(dev)) {
>  		/* Clear Root Error Status */
> -		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> -		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
>
>  		/* Enable Root Port's interrupt in response to error messages */
> -		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>  		reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
> -		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
>  	}
>
>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 7883c9791562..cbc5abfe767b 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -148,10 +148,10 @@ static int report_resume(struct pci_dev *dev, =

> void *data)
>
>  /**
>   * pci_walk_bridge - walk bridges potentially AER affected
> - * @bridge:	bridge which may be a Port, an RCEC with associated =

> RCiEPs,
> - *		or an RCiEP associated with an RCEC
> - * @cb:		callback to be called for each device found
> - * @userdata:	arbitrary pointer to be passed to callback
> + * @bridge   bridge which may be an RCEC with associated RCiEPs,
> + *           or a Port.
> + * @cb       callback to be called for each device found
> + * @userdata arbitrary pointer to be passed to callback.
>   *
>   * If the device provided is a bridge, walk the subordinate bus, =

> including
>   * any bridged devices on buses under this bus.  Call the provided =

> callback
> @@ -164,8 +164,14 @@ static void pci_walk_bridge(struct pci_dev =

> *bridge,
>  			    int (*cb)(struct pci_dev *, void *),
>  			    void *userdata)
>  {
> +	/*
> +	 * In a non-native case where there is no OS-visible reporting
> +	 * device the bridge will be NULL, i.e., no RCEC, no Downstream =

> Port.
> +	 */
>  	if (bridge->subordinate)
>  		pci_walk_bus(bridge->subordinate, cb, userdata);
> +	else if (bridge->rcec)
> +		cb(bridge->rcec, userdata);
>  	else
>  		cb(bridge, userdata);
>  }
> @@ -194,12 +200,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev =

> *dev,
>  	pci_dbg(bridge, "broadcast error_detected message\n");
>  	if (state =3D=3D pci_channel_io_frozen) {
>  		pci_walk_bridge(bridge, report_frozen_detected, &status);
> -		if (type =3D=3D PCI_EXP_TYPE_RC_END) {
> -			pci_warn(dev, "subordinate device reset not possible for =

> RCiEP\n");
> -			status =3D PCI_ERS_RESULT_NONE;
> -			goto failed;
> -		}
> -
>  		status =3D reset_subordinates(bridge);
>  		if (status !=3D PCI_ERS_RESULT_RECOVERED) {
>  			pci_warn(bridge, "subordinate device reset failed\n");
> --
> 2.29.2
