Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807D1291304
	for <lists+linux-pci@lfdr.de>; Sat, 17 Oct 2020 18:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438319AbgJQQOq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Oct 2020 12:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438314AbgJQQOp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Oct 2020 12:14:45 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9C9C0613CE
        for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2020 09:14:45 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b15so3937839iod.13
        for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2020 09:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91LwC0UHNx8CIfcjNY4cUQHdSU/TvwJYr03X/CUIqDg=;
        b=HzU9W+/OK4mToOh4dS0r47N+CZHOnKuGo33fmzTRH3Mp4qdtXNjcej+z+S7YczIbhR
         DPDnUkzLPYzm7AImZ9G8ZswRrcY1YWEATaWlHAw/1qr/97ipkQEeWehus1sDXxCvEIA+
         hwvzYMEeA99gBam3mDou6ut66pHoCbKYKJr0XkBu/FId4qUZMr3fbJny/Lk73lnRYMvs
         nEVb/dHi1HgowFJs+fxV2LOYRc7xMQ7LyjSVxigu+z27CAVF1Ti/KkAksblmYFBH3atG
         F1vUOu98TlMiHOalRSagUZaXX8Yys8YCtIXzIx/DL7CjrTEdO1KSt1NppOl60r9BxPl3
         k7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91LwC0UHNx8CIfcjNY4cUQHdSU/TvwJYr03X/CUIqDg=;
        b=Wp0rfhr3iAmAr3RHg0+8/nPnD1VNEK/66gWmVGm10RI6jUAmeFoCKttosATyGjIvP6
         ysXLdQrcxAGDpYQkKHp1W+yekmOvxZCfm2BpfQ169uux/VnYGxsftiIpj8RAE/llLwaf
         tjR8KLNmiZ9PjM32Ujl+IB6QliA6RgcM+GK+Qx/bU43WhB/HnjV8ZcJ0+YCjDNtDYTOF
         bMuOWCCkTHzC1qRDPGknCvh6aRIu2PRySX+bt30B12MnUhkAhiek9hS+LQCFvKhiOF/i
         PVIadB/y0RJjKoLJqFiY2MI1ZvQPYvEHfAA7vV6GqY3U6mY0QaJzns33Z0SlBUhYhohN
         NF4Q==
X-Gm-Message-State: AOAM531FJjV2Ognl+kidTbZOqTdATZqLamzUiXm5wGtM5NiQKk6GzF2g
        M86MBHQLMUVpQFUs+QZNe7K7Rw==
X-Google-Smtp-Source: ABdhPJzl2/wD4L7Zo3kOjhHHMZ6leW3U5AImwUiLuyG5mtJOAQ+RYwLhUigTV0xSmJdlIgf+/1+SBA==
X-Received: by 2002:a5d:9e4e:: with SMTP id i14mr6111716ioi.22.1602951284687;
        Sat, 17 Oct 2020 09:14:44 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id t16sm3361240ild.27.2020.10.17.09.14.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Oct 2020 09:14:43 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>,
        Jonathan.Cameron@huawei.com, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Sat, 17 Oct 2020 09:14:40 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <2219B080-CB26-4FE3-96BD-6C489BAAEE8C@intel.com>
In-Reply-To: <20201016203037.GA90074@bjorn-Precision-5520>
References: <20201016203037.GA90074@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16 Oct 2020, at 13:30, Bjorn Helgaas wrote:

> [+to Jonathan]
>
> On Thu, Oct 15, 2020 at 05:11:10PM -0700, Sean V Kelley wrote:
>> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>
>> When attempting error recovery for an RCiEP associated with an RCEC =

>> device,
>> there needs to be a way to update the Root Error Status, the =

>> Uncorrectable
>> Error Status and the Uncorrectable Error Severity of the parent RCEC. =

>>  In
>> some non-native cases in which there is no OS-visible device =

>> associated
>> with the RCiEP, there is nothing to act upon as the firmware is =

>> acting
>> before the OS.
>>
>> Add handling for the linked RCEC in AER/ERR while taking into account
>> non-native cases.
>>
>> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Link: =

>> https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@oregont=
racks.org
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  drivers/pci/pcie/aer.c | 53 =

>> ++++++++++++++++++++++++++++++------------
>>  drivers/pci/pcie/err.c | 20 ++++++++--------
>>  2 files changed, 48 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 65dff5f3457a..083f69b67bfd 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1357,27 +1357,50 @@ static int aer_probe(struct pcie_device *dev)
>>   */
>>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>  {
>> -	int aer =3D dev->aer_cap;
>> +	int type =3D pci_pcie_type(dev);
>> +	struct pci_dev *root;
>> +	int aer =3D 0;
>> +	int rc =3D 0;
>>  	u32 reg32;
>> -	int rc;
>>
>> +	if (pci_pcie_type(dev) =3D=3D PCI_EXP_TYPE_RC_END)
>
> "type =3D=3D PCI_EXP_TYPE_RC_END"

Right, I merged your suggested changes which added the type. Will =

correct.

>
>> +		/*
>> +		 * The reset should only clear the Root Error Status
>> +		 * of the RCEC. Only perform this for the
>> +		 * native case, i.e., an RCEC is present.
>> +		 */
>> +		root =3D dev->rcec;
>> +	else
>> +		root =3D dev;
>>
>> -	/* Disable Root's interrupt in response to error messages */
>> -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>> -	reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
>> -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>> +	if (root)
>> +		aer =3D dev->aer_cap;
>>
>> -	rc =3D pci_bus_error_reset(dev);
>> -	pci_info(dev, "Root Port link has been reset\n");
>> +	if (aer) {
>> +		/* Disable Root's interrupt in response to error messages */
>> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>> +		reg32 &=3D ~ROOT_PORT_INTR_ON_MESG_MASK;
>> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
>
> Not directly related to *this* patch, but my assumption was that in
> the APEI case, the firmware should retain ownership of the AER
> Capability, so the OS should not touch PCI_ERR_ROOT_COMMAND and
> PCI_ERR_ROOT_STATUS.
>
> But this code appears to ignore that ownership.  Jonathan, you must
> have looked at this recently for 068c29a248b6 ("PCI/ERR: Clear PCIe
> Device Status errors only if OS owns AER").  Do you have any insight
> about this?
>
>> -	/* Clear Root Error Status */
>> -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
>> -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
>> +		/* Clear Root Error Status */
>> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
>> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
>>
>> -	/* Enable Root Port's interrupt in response to error messages */
>> -	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>> -	reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
>> -	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>> +		/* Enable Root Port's interrupt in response to error messages */
>> +		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>> +		reg32 |=3D ROOT_PORT_INTR_ON_MESG_MASK;
>> +		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
>> +	}
>> +
>> +	if ((type =3D=3D PCI_EXP_TYPE_RC_EC) || (type =3D=3D PCI_EXP_TYPE_RC=
_END)) =

>> {
>> +		if (pcie_has_flr(root)) {
>> +			rc =3D pcie_flr(root);
>> +			pci_info(dev, "has been reset (%d)\n", rc);
>> +		}
>> +	} else {
>> +		rc =3D pci_bus_error_reset(root);
>
> Don't we want "dev" for both the FLR and pci_bus_error_reset()?  I
> think "root =3D=3D dev" except when dev is an RCiEP.  When dev is an
> RCiEP, "root" is the RCEC (if present), and we want to reset the
> RCiEP, not the RCEC.

Right, when I did the goto in the earlier incarnation, I always set root =

to dev at the start and in the merge it needs to be dev always except =

for the RC_END where RCEC exists. Will change without bringing back the =

goto=E2=80=A6

+       struct pci_dev *root =3D dev;

=E2=80=A6

+non_native:
+       if ((type =3D=3D PCI_EXP_TYPE_RC_EC) || (type =3D=3D
PCI_EXP_TYPE_RC_END)) {
+               rc =3D flr_on_rc(root);
+               pci_info(dev, "has been reset (%d)\n", rc);
+       } else {
+               rc =3D pci_bus_error_reset(root);
+               pci_info(dev, "Root Port link has been reset (%d)\n",
rc);
+       }


>
>> +		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
>> +	}
>
> There are a couple changes here that I think should be split out.
>
> Based on my theory that when firmware retains control of AER, the OS
> should not touch PCI_ERR_ROOT_COMMAND and PCI_ERR_ROOT_STATUS, and any
> updates to them would have to be done by firmware before we get here,
> I suggested reordering this:
>
>   - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>   - do reset
>   - clear PCI_ERR_ROOT_STATUS (for APEI, presumably done by firmware?)
>   - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>
> to this:
>
>   - clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>   - clear PCI_ERR_ROOT_STATUS
>   - enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
>   - do reset
>
> If my theory is correct, I think we should still reorder this, but:
>
>   - It's a significant behavior change that deserves its own patch so
>     we can document/bisect/revert.
>
>   - I'm not sure why we clear the PCI_ERR_ROOT_COMMAND error reporting
>     bits.  In the new "clear COMMAND, clear STATUS, enable COMMAND"
>     order, it looks superfluous.  There's no reason to disable error
>     reporting while clearing the status bits.
>
>     The current "clear, reset, enable" order suggests that the reset
>     might cause errors that we should ignore.  I don't know whether
>     that's the case or not.  It dates from 6c2b374d7485 ("PCI-Express
>     AER implemetation: AER core and aerdriver"), which doesn't
>     elaborate.
>
>   - Should we also test for OS ownership of AER before touching
>     PCI_ERR_ROOT_STATUS?
>
>   - If we remove the PCI_ERR_ROOT_COMMAND fiddling (and I tentatively
>     think we *should* unless we can justify it), that would also
>     deserve its own patch.  Possibly (1) remove PCI_ERR_ROOT_COMMAND
>     fiddling, (2) reorder PCI_ERR_ROOT_STATUS clearing and reset, (3)
>     test for OS ownership of AER (?), (4) the rest of this patch.

You=E2=80=99ve highlighted some good questions.

I think we should remove the fiddling until we have a clearer picture =

and put that into its own patch.

Sean
>
>>  	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>>  }
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 7883c9791562..cbc5abfe767b 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -148,10 +148,10 @@ static int report_resume(struct pci_dev *dev, =

>> void *data)
>>
>>  /**
>>   * pci_walk_bridge - walk bridges potentially AER affected
>> - * @bridge:	bridge which may be a Port, an RCEC with associated =

>> RCiEPs,
>> - *		or an RCiEP associated with an RCEC
>> - * @cb:		callback to be called for each device found
>> - * @userdata:	arbitrary pointer to be passed to callback
>> + * @bridge   bridge which may be an RCEC with associated RCiEPs,
>> + *           or a Port.
>> + * @cb       callback to be called for each device found
>> + * @userdata arbitrary pointer to be passed to callback.
>>   *
>>   * If the device provided is a bridge, walk the subordinate bus, =

>> including
>>   * any bridged devices on buses under this bus.  Call the provided =

>> callback
>> @@ -164,8 +164,14 @@ static void pci_walk_bridge(struct pci_dev =

>> *bridge,
>>  			    int (*cb)(struct pci_dev *, void *),
>>  			    void *userdata)
>>  {
>> +	/*
>> +	 * In a non-native case where there is no OS-visible reporting
>> +	 * device the bridge will be NULL, i.e., no RCEC, no Downstream =

>> Port.
>> +	 */
>>  	if (bridge->subordinate)
>>  		pci_walk_bus(bridge->subordinate, cb, userdata);
>> +	else if (bridge->rcec)
>> +		cb(bridge->rcec, userdata);
>>  	else
>>  		cb(bridge, userdata);
>>  }
>> @@ -194,12 +200,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev =

>> *dev,
>>  	pci_dbg(bridge, "broadcast error_detected message\n");
>>  	if (state =3D=3D pci_channel_io_frozen) {
>>  		pci_walk_bridge(bridge, report_frozen_detected, &status);
>> -		if (type =3D=3D PCI_EXP_TYPE_RC_END) {
>> -			pci_warn(dev, "subordinate device reset not possible for =

>> RCiEP\n");
>> -			status =3D PCI_ERS_RESULT_NONE;
>> -			goto failed;
>> -		}
>> -
>>  		status =3D reset_subordinates(bridge);
>>  		if (status !=3D PCI_ERS_RESULT_RECOVERED) {
>>  			pci_warn(bridge, "subordinate device reset failed\n");
>> -- =

>> 2.28.0
>>
