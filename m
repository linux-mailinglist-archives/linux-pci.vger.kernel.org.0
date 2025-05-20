Return-Path: <linux-pci+bounces-28069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E31FABD0D7
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 09:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A405D8A5031
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4925E47E;
	Tue, 20 May 2025 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W7HNr4q4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6D325E478
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727240; cv=none; b=LesjPzFDWjB1Fbbt5EADLfDPBZMm9guC2kprLrBFTC3/cLrxr7sgEnbvbmrnXrPdY7CAS/I4sLfRDuEjZmeGCRnMziCF7mUPgfPNSp+mnsyV2C6T/4j3uL82O/QQMJPTWjpg/16xtXUMDrRiqK2ljO+tALTgxpuSk0t0036dgy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727240; c=relaxed/simple;
	bh=Kpm9h0rvihffqis4R4vZ2mYBLP/Gag8NA4K5sznq4l8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kq2PVwShIabzZzI3ufw9r7Ax6+TA3Zbf7DZsWPrJiVzuO6sb7A2eTIQqBVZxjhTCXWe5C1qBaeYLduEcYxfLkJSKiP3r4X4VdQhmWCs7i8z6TQIHZt1Z9A/Urtei+DZSNy9orCGQF3IXxi3nxhI48B2CgnXN6s0eUzI4jV5xZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W7HNr4q4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ede096d73so37293775e9.2
        for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 00:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747727235; x=1748332035; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPt0o2K+oGzEB06+9C4F+pNiGIiK4IzFmR46KIgZKE8=;
        b=W7HNr4q4u1vLqC3/80M0P2/DgpRcSPrDP/VxtHm9dB3j4Jj7bEHCranvlGGxORM0eg
         FJTpzogmspxoNrZXbLh2iFLGX0kwpv3dYWreiBsj6/CefYwu1SK+O8oNTlABgEf9GCqI
         KrNn/qRKU74u+c/QYDDi5b2PpbICNs6kLenaukHn6/HI7CFclpMRQjy/Y5XEem/t8nMW
         vY456zYfqQGi2JPyL+JzV4p+WTtgUmarRywoo7oHf1Lsnf2Fa9cE4KysWZlxhRU3ReXw
         O8qRIUuE0kY6NUGUxdnRTAQkS/8NaLymW8kZFQkhaept98eQbCXkI8v6V2w6nSRk5bJY
         yaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747727235; x=1748332035;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPt0o2K+oGzEB06+9C4F+pNiGIiK4IzFmR46KIgZKE8=;
        b=hrO/SfG11DHj4CvVgMHgZuZ3yCWnEuBrojWBaJ83vqPV3dUQi/H6cQ0ls9fa7U22Fh
         CCSK80czYW6HcCa/sNFMHj3PLXydFM2DGx+EzVzYmbxNfRWbiss1fb0MUG8Kxaz/RJwQ
         bdPUDd11FIuO6PAUuC/m2EWCKAC7F8cWyXSsnkXNzO6HdLe6jZVoDt5hLT6dc6sTogSE
         zo86avsn6tzuxeMZNPFTDrw0aUs88DjYNCqrQSDWZELzvxY0kcFYlsl+T67JM9/AOnwo
         98AoubxKmuejIHA9GHOA1LdTfzxn4L+RDmdzseFkjB3yOR66Tm/UeoSJMq4oMLC+ZpO/
         elBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzRIO0q2AnDB2zATItFaCnd6o18Q1hmr9RZFZTsB6OTfWWyv/Mva6OjHftE44JESnmmYBBke+IpFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMvIufnZWA1GuskrJWtaUMs4GL2RqO4Y/9RWDVDgs9bBwnn9eA
	nuvCEUtCqDJVlv6GP1OM6PrUOs5mmlTo+QdXdHoSMxf5f072f2ZcFcJ+NIOO1LKFGBU=
X-Gm-Gg: ASbGncvcL2tp7PJ411gpd4omYFB5VXqHC3miKSxUxDqMXLjndJU8Elm8XOis2etUepi
	7SLU6udYwnsnpGeNJYEJVGwuhOdn9226NFnBwXqV+34c4MBDlhulAgKIt0o+yHot9zu8KIEOJze
	0jH+fOaianiHQkRTLeXcQD9ZLiovAO2531CobJu2ZZdjvJf7czfNaBtS2qgEqs6VEyEUxi8tqT8
	XAqxJJm4jZBA675Tf7xX4jRdsE8Kd6VzLfShQwaXnL7LITthX+oTNBS2JoIQFomx7Ml2Iwzq+BD
	wLPg/w+/m/AlIRIcUgICH/c/4f1Sz0CvsoY7CpTaR7HioV51xFQ=
X-Google-Smtp-Source: AGHT+IEb01nulIXG8TDu/HvYRGPeBja6SuFSoReBd0lMj3lS0DdvyZ5S4ftHcPw+KDy6kEhj4gctzA==
X-Received: by 2002:a05:6000:186d:b0:3a3:6b0c:a8a3 with SMTP id ffacd0b85a97d-3a36b0ca9b1mr6702803f8f.17.1747727235544;
        Tue, 20 May 2025 00:47:15 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:f683:3887:7e7c:b492])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca4d105sm15702162f8f.11.2025.05.20.00.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 00:47:15 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>,  Dave Jiang <dave.jiang@intel.com>,  Allen
 Hubbe <allenbh@gmail.com>,  Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
  Kishon Vijay Abraham I <kishon@kernel.org>,  Bjorn Helgaas
 <bhelgaas@google.com>,  ntb@lists.linux.dev,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: endpoint: pci-epf-vntb: align mw naming with
 config names
In-Reply-To: <aCugvDoKTflV9+P0@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Mon, 19 May 2025 17:21:00 -0400")
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
	<20250505-pci-vntb-bar-mapping-v1-2-0e0d12b2fa71@baylibre.com>
	<aCugvDoKTflV9+P0@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 20 May 2025 09:47:14 +0200
Message-ID: <1jecwjn2pp.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 19 May 2025 at 17:21, Frank Li <Frank.li@nxp.com> wrote:

> On Mon, May 05, 2025 at 07:41:48PM +0200, Jerome Brunet wrote:
>
> PCI tree require keep consistent at subject
> git log --oneline drivers/pci/endpoint/functions/pci-epf-vntb.c
>
> require first char is UP case.

Noted

>
> Align memory window naming with configfs names.
>
>> The config file related to the memory windows start the numbering of
>
>                                  memory windows (MW)
>  then you can use MW later.

Sure

>
>> the MW from 1. The other NTB function does the same, yet the enumeration
>> defining the BARs of the vNTB function starts numbering the MW from 0.
>>
>> Both numbering are fine I suppose but mixing the two is a bit confusing.
>> The configfs file being the interface with userspace, lets keep that stable
>> and consistently start the numbering of the MW from 1.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> index 35fa0a21fc91100a5539bff775e7ebc25e1fb9c1..f9f4a8bb65f364962dbf1e9011ab0e4479c61034 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> @@ -70,9 +70,10 @@ static struct workqueue_struct *kpcintb_workqueue;
>>  enum epf_ntb_bar {
>>  	BAR_CONFIG,
>>  	BAR_DB,
>> -	BAR_MW0,
>>  	BAR_MW1,
>>  	BAR_MW2,
>> +	BAR_MW3,
>> +	BAR_MW4,
>
> where use BAR_MW3 and BAR_MW4?

This is aligned with the file available in configfs and what is possible
in theory with the function, same as the NTB function and NTB host driver.

Stopping at MW1 because it is only one used in the driver would be weird
and the number later introduced would be wrong.


>
> Frank
>>  };
>>
>>  /*
>> @@ -576,7 +577,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>>
>>  	for (i = 0; i < ntb->num_mws; i++) {
>>  		size = ntb->mws_size[i];
>> -		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
>> +		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
>>
>>  		ntb->epf->bar[barno].barno = barno;
>>  		ntb->epf->bar[barno].size = size;
>> @@ -629,7 +630,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>>  	int i;
>>
>>  	for (i = 0; i < num_mws; i++) {
>> -		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
>> +		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
>>  		pci_epc_clear_bar(ntb->epf->epc,
>>  				  ntb->epf->func_no,
>>  				  ntb->epf->vfunc_no,
>> @@ -676,7 +677,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>>  	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
>>
>>  	/* These are required BARs which are mandatory for NTB functionality */
>> -	for (bar = BAR_CONFIG; bar <= BAR_MW0; bar++, barno++) {
>> +	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
>>  		barno = pci_epc_get_next_free_bar(epc_features, barno);
>>  		if (barno < 0) {
>>  			dev_err(dev, "Fail to get NTB function BAR\n");
>> @@ -1048,7 +1049,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>>  	struct device *dev;
>>
>>  	dev = &ntb->ntb.dev;
>> -	barno = ntb->epf_ntb_bar[BAR_MW0 + idx];
>> +	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>>  	epf_bar = &ntb->epf->bar[barno];
>>  	epf_bar->phys_addr = addr;
>>  	epf_bar->barno = barno;
>>
>> --
>> 2.47.2
>>

-- 
Jerome

