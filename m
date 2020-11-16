Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4592B4C40
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 18:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbgKPRKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 12:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730994AbgKPRKd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 12:10:33 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A07C0613D1
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2020 09:10:32 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id m65so13344689qte.11
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2020 09:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x72RPnvcZQrq4B1bODPljxMr+0GZzaGWEw6swyrl9Wk=;
        b=zGq4R32CvDspJZ028Zj0Uh4j9cx+kgs6/j/Fnvn6ifCfz8cmDKZDlMvu15Dlh6o0MO
         p1FhmaRxZofqzbqw3C9rsTOSFljfou6jqgNp71Wc0u2LjXwayZ6jGBCR/9SEuTAIik+1
         cj/uEIYHSjnjebNplDNICFwPO4EGke9tKhmQ2G0ZC9jwrZ0D8mg4aXoG3xJx4gdIoSkz
         hyEyXoxWCkdwVtJ22KCrWLCfHDgB+vCoit/BoKp+FvS2PVn/QWVupdb9OR/i1yuirqZw
         lBUGWrP+wNz6IexMjv/125n6jU6YkV9RpAeirYFEZE40AsuY4BOmxhQDkuVgkVn3yyQR
         kypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x72RPnvcZQrq4B1bODPljxMr+0GZzaGWEw6swyrl9Wk=;
        b=KlngqVDaXRXdk378c86KY/resEtLDoRxxZpRQlID9aPDuViidy65UXCKxSyrL6Ov07
         ulyfnaTlmlwyrRMSodim++6eg4MzAuDrEzcv7DrlU4L7iZjdAbNV8KKtJJCp32IeAkQi
         hy2OgsPDCZvdWEV4h/TD10RAKuSTK+Y/ZqTuz6kmVmLrr9pYx/vMFcnn6X2HhFQ00Hab
         5iLtuZj/8vCJuEHEtM23hZ8UlZTIOGcWz0cheK99mV5zm5B1zuClIyBwABQDPCZi8S63
         w4rG47Feqs414bo1HujIlG+OzOX7bpsvnJxr32UwrRXrs70EUkBH5Fi0OP9Y4Tsr/5d+
         gkRQ==
X-Gm-Message-State: AOAM532Qk7Ps8HcN2YEHvjchNV02DppODLhuXQAInwU83iJnj6a4f/kA
        KWFbu2K1NrRBCHp/st8SrWXtag==
X-Google-Smtp-Source: ABdhPJz5CyKQHXsmSQHjq5fTsnlBef8Fon2OcyViVRMVHrBOVIHsi49nThD+kCb+Zjp33aVbIsOCLw==
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr14807102qta.309.1605546632041;
        Mon, 16 Nov 2020 09:10:32 -0800 (PST)
Received: from [192.168.1.100] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id q32sm8068247qtb.71.2020.11.16.09.10.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 09:10:31 -0800 (PST)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] AER: aer_root_reset() non-native handling
Date:   Mon, 16 Nov 2020 09:10:28 -0800
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <43FBC4C0-BAC1-468A-AE59-173C8447F630@intel.com>
In-Reply-To: <20201114153718.GA1170994@bjorn-Precision-5520>
References: <20201114153718.GA1170994@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14 Nov 2020, at 7:37, Bjorn Helgaas wrote:

> On Wed, Nov 04, 2020 at 03:22:44PM -0800, Sean V Kelley wrote:
>> If an OS has not been granted AER control via _OSC, then
>> the OS should not make changes to PCI_ERR_ROOT_COMMAND and
>> PCI_ERR_ROOT_STATUS related registers. Per section 4.5.1 of
>> the System Firmware Intermediary (SFI) _OSC and DPC Updates
>> ECN [1], this bit also covers these aspects of the PCI
>> Express Advanced Error Reporting. Based on the above and
>> earlier discussion [2], make the following changes:
>>
>> Add a check for the native case (i.e., AER control via _OSC)
>>
>> Note that the current "clear, reset, enable" order suggests that the
>> reset might cause errors that we should ignore. Lacking historical
>> context, these will be retained.
>>
>> [1] System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb =

>> 24,
>>     2020, affecting PCI Firmware Specification, Rev. 3.2
>>     https://members.pcisig.com/wg/PCI-SIG/document/14076
>> [2] =

>> https://lore.kernel.org/linux-pci/20201020162820.GA370938@bjorn-Precis=
ion-5520/
>>
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>
> What do I do with this patch in combination with "[PATCH v10 00/16]
> Add RCEC handling to PCI/AER"?  I tried applying this and the RCEC
> series on top, but they conflict.
>
> I was thinking it would be easiest to include this as the first patch
> in the series so I wouldn't have to resolve the conflicts, but maybe
> you had something else in mind?

It originally did rebase but the last minute %s/root/dev changes may =

have broke the rebase.
Will fix and submit as the first patch in the RCEC series.


>
>> ---
>> Changes since V2 :
>>
>> Fixed an unfortunate copy/paste error.
>>
>> Changes since V1 [1]:
>>
>> Noted lack of historical context on isolation of both the
>> pci_bus_error_reset() and the clearing of Root Error Status. In fact,
>> the call to aer_enable_rootport() likewise disables system error =

>> generation
>> in response to error messages around the clearing of the error =

>> status. So
>> retained the wrapping of the  "clear, reset, enable".
>>
>> [1] =

>> https://lore.kernel.org/linux-pci/20201030223443.165783-1-sean.v.kelle=
y@intel.com/
>>
>> Thanks,
>>
>> Sean
>> ---
>>  drivers/pci/pcie/aer.c | 31 +++++++++++++++++--------------
>>  1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 65dff5f3457a..4ab379fa1506 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1358,26 +1358,29 @@ static int aer_probe(struct pcie_device *dev)
>>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>  {
>>  	int aer =3D dev->aer_cap;
>> +	int rc =3D 0;
>
> Unnecessary init, I think.

Will remove init.

Thanks,

Sean

>
>>  	u32 reg32;
>> -	int rc;
>> -
>>
>> -	/* Disable Root's interrupt in response to error messages */
>> -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>> -	reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
>> -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>> +	if (pcie_aer_is_native(dev)) {
>> +		/* Disable Root's interrupt in response to error messages */
>> +		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>> +		reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
>> +		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>> +	}
>>
>>  	rc =3D pci_bus_error_reset(dev);
>> -	pci_info(dev, "Root Port link has been reset\n");
>> +	pci_info(dev, "Root Port link has been reset (%d)\n", rc);
>>
>> -	/* Clear Root Error Status */
>> -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
>> -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
>> +	if (pcie_aer_is_native(dev)) {
>> +		/* Clear Root Error Status */
>> +		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
>> +		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
>>
>> -	/* Enable Root Port's interrupt in response to error messages */
>> -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>> -	reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
>> -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>> +		/* Enable Root Port's interrupt in response to error messages */
>> +		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>> +		reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
>> +		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>> +	}
>>
>>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>>  }
>> --
>> 2.29.2
>>
