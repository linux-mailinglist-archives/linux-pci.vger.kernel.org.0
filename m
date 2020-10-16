Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8671290ADC
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 19:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390700AbgJPRg2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733088AbgJPRgY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2020 13:36:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042DBC0613D3
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2020 10:36:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id p21so1764188pju.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2020 10:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b0NxEiR9ivavFc0Jqy/jtl7ltzxrQHnl1HNNW0pqUTw=;
        b=hS7kj0TplfyP1Xsxf+GvR6o8Q1+dUSCCUeVywv4xj3dNlGqTMlArTmTdQ2fchuFikv
         zB0/H3LOTPHBdC2uXkIZvvE4OwGsKBOVF0GlUqG8/lLVdaUd/5EVl5HuVFF4qDCB+CEb
         3hsxOPX1Tpka3rRW3QVWiSA2PR5YqFpkc9ofeoirgrHTnl23RxUWFQw+GHwDc7q1JCT6
         sVqzkC3D6Da9Ye3DgTwvqtqeWP5mCnZgxEbfgRtu8+oJWLGnTekBOQqMShl1d84ia8vG
         4o2BA99yCY7vr3f+0Flpln7E0cdJByTx5IU2WUe9hlZxOX6uyyH/aks5qmEdHPn4kUJP
         7NIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b0NxEiR9ivavFc0Jqy/jtl7ltzxrQHnl1HNNW0pqUTw=;
        b=Lt4j0lb5bq11Mj/Eb/ZFgciODpxr0pIJXNbnUuL2qfz0KBTqI9cC2n0xbcRSCPFxeq
         dv7CV+p6xuE4GMeOJi2MGSE8xU2Mug15xtMwsSDqTNpaYhEcC55vNYwhhf7PgvcO3XLr
         oyAC0M6GMsc/1zGDktzKB7AQXRwlC3AnMqbYVhe06mxY3FGVzBAMSZklgQ9UAoL4gV3c
         Wzfhuhrfcev3T0mCqO6QB08Cdbr56VFVL0zByIRhGmWTrNi01hHatoQjEQ5xiVYbbKtN
         aXFky3vTjXl7cVI4iixh0IJ2NZOYDLQ93ldyIfntZF13Q16FwZZo2iQidYg2+MPyVjYJ
         oGzQ==
X-Gm-Message-State: AOAM531Aw1zAKYC5DQ2lIM8vs4KDLobE/l+LdmwGFicn1/TFcW/KNGUG
        gpmT+FFpH8kGH2bL618aEjx8Bw==
X-Google-Smtp-Source: ABdhPJwfPtalLr/bCxHuL1IwRgnEbvznCze5AWo10rbFuYNnABsfCtIq1/D1HANP9gHXMRYGugZvZg==
X-Received: by 2002:a17:90b:3010:: with SMTP id hg16mr4856194pjb.21.1602869783273;
        Fri, 16 Oct 2020 10:36:23 -0700 (PDT)
Received: from [10.213.166.74] ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id 8sm3554202pfj.44.2020.10.16.10.36.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Oct 2020 10:36:22 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 10/15] PCI/ERR: Limit AER resets in pcie_do_recovery()
Date:   Fri, 16 Oct 2020 10:36:19 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <7E259265-CE19-450D-A902-6C531690939D@intel.com>
In-Reply-To: <20201016172210.GA86168@bjorn-Precision-5520>
References: <20201016172210.GA86168@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 16 Oct 2020, at 10:22, Bjorn Helgaas wrote:

> On Thu, Oct 15, 2020 at 05:11:08PM -0700, Sean V Kelley wrote:
>> From: Sean V Kelley <sean.v.kelley@intel.com>
>>
>> In some cases a bridge may not exist as the hardware controlling may =

>> be
>> handled only by firmware and so is not visible to the OS. This =

>> scenario is
>> also possible in future use cases involving non-native use of RCECs =

>> by
>> firmware.
>>
>> Explicitly apply conditional logic around these resets by limiting =

>> them to
>> Root Ports and Downstream Ports.
>>
>> Link: =

>> https://lore.kernel.org/r/20201002184735.1229220-8-seanvk.dev@oregontr=
acks.org
>> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>  drivers/pci/pcie/err.c | 31 +++++++++++++++++++++++++------
>>  1 file changed, 25 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 8b53aecdb43d..7883c9791562 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -148,13 +148,17 @@ static int report_resume(struct pci_dev *dev, =

>> void *data)
>>
>>  /**
>>   * pci_walk_bridge - walk bridges potentially AER affected
>> - * @bridge:	bridge which may be a Port
>> + * @bridge:	bridge which may be a Port, an RCEC with associated =

>> RCiEPs,
>> + *		or an RCiEP associated with an RCEC
>>   * @cb:		callback to be called for each device found
>>   * @userdata:	arbitrary pointer to be passed to callback
>>   *
>>   * If the device provided is a bridge, walk the subordinate bus, =

>> including
>>   * any bridged devices on buses under this bus.  Call the provided =

>> callback
>>   * on each device found.
>> + *
>> + * If the device provided has no subordinate bus, call the callback =

>> on the
>> + * device itself.
>>   */
>>  static void pci_walk_bridge(struct pci_dev *bridge,
>>  			    int (*cb)(struct pci_dev *, void *),
>> @@ -162,6 +166,8 @@ static void pci_walk_bridge(struct pci_dev =

>> *bridge,
>>  {
>>  	if (bridge->subordinate)
>>  		pci_walk_bus(bridge->subordinate, cb, userdata);
>> +	else
>> +		cb(bridge, userdata);
>
> Looks like *this* is the patch where the "no subordinate bus" case
> becomes possible?  If you agree, I can just move the test here, no
> need to repost.

Agree, this is the patch that the check is needed as we are opening =

things up for walking RC_ECs and RC_ENDs as below.

Sean


>
>>  }
>>
>>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>> @@ -174,10 +180,13 @@ pci_ers_result_t pcie_do_recovery(struct =

>> pci_dev *dev,
>>
>>  	/*
>>  	 * Error recovery runs on all subordinates of the bridge.  If the
>> -	 * bridge detected the error, it is cleared at the end.
>> +	 * bridge detected the error, it is cleared at the end.  For RCiEPs
>> +	 * we should reset just the RCiEP itself.
>>  	 */
>>  	if (type =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
>> -	    type =3D=3D PCI_EXP_TYPE_DOWNSTREAM)
>> +	    type =3D=3D PCI_EXP_TYPE_DOWNSTREAM ||
>> +	    type =3D=3D PCI_EXP_TYPE_RC_EC ||
>> +	    type =3D=3D PCI_EXP_TYPE_RC_END)
>>  		bridge =3D dev;
>>  	else
>>  		bridge =3D pci_upstream_bridge(dev);
>> @@ -185,6 +194,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev =

>> *dev,
>>  	pci_dbg(bridge, "broadcast error_detected message\n");
>>  	if (state =3D=3D pci_channel_io_frozen) {
>>  		pci_walk_bridge(bridge, report_frozen_detected, &status);
>> +		if (type =3D=3D PCI_EXP_TYPE_RC_END) {
>> +			pci_warn(dev, "subordinate device reset not possible for =

>> RCiEP\n");
>> +			status =3D PCI_ERS_RESULT_NONE;
>> +			goto failed;
>> +		}
>> +
>>  		status =3D reset_subordinates(bridge);
>>  		if (status !=3D PCI_ERS_RESULT_RECOVERED) {
>>  			pci_warn(bridge, "subordinate device reset failed\n");
>> @@ -217,9 +232,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev =

>> *dev,
>>  	pci_dbg(bridge, "broadcast resume message\n");
>>  	pci_walk_bridge(bridge, report_resume, &status);
>>
>> -	if (pcie_aer_is_native(bridge))
>> -		pcie_clear_device_status(bridge);
>> -	pci_aer_clear_nonfatal_status(bridge);
>> +	if (type =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
>> +	    type =3D=3D PCI_EXP_TYPE_DOWNSTREAM ||
>> +	    type =3D=3D PCI_EXP_TYPE_RC_EC) {
>> +		if (pcie_aer_is_native(bridge))
>> +			pcie_clear_device_status(bridge);
>> +		pci_aer_clear_nonfatal_status(bridge);
>> +	}
>>  	pci_info(bridge, "device recovery successful\n");
>>  	return status;
>>
>> -- =

>> 2.28.0
>>
