Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFC322F3FC
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 17:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgG0Pjo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbgG0Pjn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2020 11:39:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87079C0619D2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:39:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id lw1so1372367pjb.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2020 08:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qeeFM2bqqm7Pdc6T9HvDOkYabM11vNorXeX2zlS9K54=;
        b=vhf34NpACds/YSGc71eoyGJ72NMM4ZORy5yA3ZXbCrStEESeeFyyVkF300KCQaBC8w
         PSaKk+FFNnGB0sf6xvZDd3BMDMkNhLqSUKtwwU4G8T/cMah+XdAe8M5J3lXpcfClB/c7
         y3i6SaKs4u3NrbsrRScVX7Vq9nyEHH2lKsM3PYK3sxWLm3qRDXd1LyTnX6TQqSNae7EI
         eIneM6S8FwgM+2lf2XyF77m7PFzF2rSUtgVFvqH8DW0sz1bwanvY39B1MRH/ylt0wl4f
         HJZS8OSKEeJ5F39Qj6gJE2c4a9z2azeod2fzwFU3wzSLlY8/gaa8+RHBUfcYDEJOa4oC
         UzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qeeFM2bqqm7Pdc6T9HvDOkYabM11vNorXeX2zlS9K54=;
        b=eT9S4+IpxUwhMyhDYuWXjIg97ZwhTReAtZyLiBaP/anR6RokRL4AXxk2y5Zgji4713
         vOuhDoH+udI06UEbDYGi2OqH6WdpZb0B5pb3PlXCX1lkiVI0Qiy5M/33CvcNYvuy6l4J
         ltIl8JwnqgpQvPp/gVkLiO3srYiqLS28Av9kI2migE9MGj91fJmCzFExoIi5jnYTuLhR
         13O5VXTonsuF8Q2epUzuGGpFlmgTem7vnUHAQvlaznja1xDB65Qbmg1lksYDCZ/a8CtU
         323/EndpJDKMFmst73I0oucP1bkoQJOMrkxnxoqVy1eFnvcEtX32DtTdhB2U7QOlRErz
         b9Pg==
X-Gm-Message-State: AOAM530QRph6+NCUnJt1nIEJOLxmimpcE5auNn/8Qd0nLcdDLUGdM5vG
        LF/lCFOPmczwex2GyK+IrVYaqA==
X-Google-Smtp-Source: ABdhPJyqMal+7S3RURFS+mH7372yuxqLtS6DhV/dJoOjNq1VsqZhaUjtImYT21fxJGhSXLaKgBfcTQ==
X-Received: by 2002:a17:902:bd90:: with SMTP id q16mr18126853pls.54.1595864382998;
        Mon, 27 Jul 2020 08:39:42 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id s22sm14545536pgv.43.2020.07.27.08.39.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2020 08:39:42 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     bhelgaas@google.com, rjw@rjwysocki.net,
        "Raj, Ashok" <ashok.raj@intel.com>, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Subject: Re: [RFC PATCH 6/9] PCI: Add 'rcec' field to pci_dev for associated
 RCiEPs
Date:   Mon, 27 Jul 2020 08:39:43 -0700
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <9C45284A-6959-4CDE-AD56-2A9B9536403C@intel.com>
In-Reply-To: <20200727122358.00006c23@Huawei.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
 <20200724172223.145608-7-sean.v.kelley@intel.com>
 <20200727122358.00006c23@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27 Jul 2020, at 4:23, Jonathan Cameron wrote:

> On Fri, 24 Jul 2020 10:22:20 -0700
> Sean V Kelley <sean.v.kelley@intel.com> wrote:
>
>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>
>> When attempting error recovery for an RCiEP associated with an RCEC =

>> device,
>> there needs to be a way to update the Root Error Status, the =

>> Uncorrectable
>> Error Status and the Uncorrectable Error Severity of the parent RCEC.
>> So add the 'rcec' field to the pci_dev structure and provide a hook =

>> for the
>> Root Port Driver to associate RCiEPs with their respective parent =

>> RCEC.
>>
>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>
> I haven't tested yet, but I think there is one path in here that =

> breaks
> my case (no OS visible rcec / all done in firmware GHESv2 / APEI)
>
> Jonathan

Okay, keep me up to date and if there is a way I can reproduce or better =

test for your use case let me know and I will do so.

>
>> ---
>>  drivers/pci/pcie/aer.c         |  9 +++++----
>>  drivers/pci/pcie/err.c         |  9 +++++++++
>>  drivers/pci/pcie/portdrv_pci.c | 15 +++++++++++++++
>>  include/linux/pci.h            |  3 +++
>>  4 files changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 3acf56683915..f1bf06be449e 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1335,17 +1335,18 @@ static int aer_probe(struct pcie_device *dev)
>>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>  {
>>  	int aer =3D dev->aer_cap;
>> +	int rc =3D 0;
>>  	u32 reg32;
>> -	int rc;
>> -
>>
>>  	/* Disable Root's interrupt in response to error messages */
>>  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>>  	reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
>>  	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>>
>> -	rc =3D pci_bus_error_reset(dev);
>> -	pci_info(dev, "Root Port link has been reset\n");
>> +	if (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_RC_EC) {
>> +		rc =3D pci_bus_error_reset(dev);
>> +		pci_info(dev, "Root Port link has been reset\n");
>> +	}
>>
>>  	/* Clear Root Error Status */
>>  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 9b3ec94bdf1d..0aae7643132e 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -203,6 +203,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev =

>> *dev,
>>  		pci_walk_dev_affected(dev, report_frozen_detected, &status);
>>  		if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_END) {
>>  			status =3D flr_on_rciep(dev);
>> +			/*
>> +			 * The callback only clears the Root Error Status
>> +			 * of the RCEC (see aer.c).
>> +			 */
>> +			reset_link(dev->rcec);
>
> This looks dangerous for my case where APEI / GHESv2 is used.  In that =

> case
> we don't expose an RCEC at all.   I don't think the reset_link =

> callback
> is safe to a null pointer here.  Fix may be as simple as
> if (dev->rcec)
> 	reset_link(dev->rcec);

Good catch.  Will look to NULL case as well as walk through code where =

dev->rcec is further referenced (below and elsewhere) to ensure nothing =

falls through. Glad you are pointing these out.

>
>
>>  			if (status !=3D PCI_ERS_RESULT_RECOVERED) {
>>  				pci_warn(dev, "function level reset failed\n");
>>  				goto failed;
>> @@ -246,7 +251,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev =

>> *dev,
>>  	     pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_EC)) {
>>  		pci_aer_clear_device_status(dev);
>>  		pci_aer_clear_nonfatal_status(dev);
>> +	} else if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_END) {
>> +		pci_aer_clear_device_status(dev->rcec);
>> +		pci_aer_clear_nonfatal_status(dev->rcec);
>
> These may be safe as in my both now have protections for =

> !pcie_aer_is_native.
>
I=E2=80=99ll have a look again for the NULL case

>>  	}
>> +
>>  	pci_info(dev, "device recovery successful\n");
>>  	return status;
>>
>> diff --git a/drivers/pci/pcie/portdrv_pci.c =

>> b/drivers/pci/pcie/portdrv_pci.c
>> index d5b109499b10..f9409a0110c2 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -90,6 +90,18 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops =

>> =3D {
>>  #define PCIE_PORTDRV_PM_OPS	NULL
>>  #endif /* !PM */
>>
>> +static int pcie_hook_rcec(struct pci_dev *pdev, void *data)
>> +{
>> +	struct pci_dev *rcec =3D (struct pci_dev *)data;
>> +
>> +	pdev->rcec =3D rcec;
>> +	pci_info(rcec, "RCiEP(under an RCEC) %04x:%02x:%02x.%d\n",
>> +		 pci_domain_nr(pdev->bus), pdev->bus->number,
>> +		 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>
> We may want to make this debug info at somepoint if we have a way
> of discovering it from userspace.   The PCI boot up is extremely
> verbose already!

I=E2=80=99ve submitted patches to pciutils, which expose this very detail=
:

https://lore.kernel.org/linux-pci/20200624223940.240463-1-sean.v.kelley@l=
inux.intel.com/

Flexible either way, could remove or make it debug info.

Thanks,

Sean

>
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * pcie_portdrv_probe - Probe PCI-Express port devices
>>   * @dev: PCI-Express port device being probed
>> @@ -110,6 +122,9 @@ static int pcie_portdrv_probe(struct pci_dev =

>> *dev,
>>  	     (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_RC_EC)))
>>  		return -ENODEV;
>>
>> +	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_EC)
>> +		pcie_walk_rcec(dev, pcie_hook_rcec, dev);
>> +
>>  	status =3D pcie_port_device_register(dev);
>>  	if (status)
>>  		return status;
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 34c1c4f45288..e920f29df40b 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -326,6 +326,9 @@ struct pci_dev {
>>  #ifdef CONFIG_PCIEAER
>>  	u16		aer_cap;	/* AER capability offset */
>>  	struct aer_stats *aer_stats;	/* AER stats for this device */
>> +#endif
>> +#ifdef CONFIG_PCIEPORTBUS
>> +	struct pci_dev	*rcec;		/* Associated RCEC device */
>>  #endif
>>  	u8		pcie_cap;	/* PCIe capability offset */
>>  	u8		msi_cap;	/* MSI capability offset */
