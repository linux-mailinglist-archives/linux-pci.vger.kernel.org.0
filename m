Return-Path: <linux-pci+bounces-28231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC7EABFB76
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 18:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9BB61BA30F9
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 16:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5B422C35D;
	Wed, 21 May 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SFwYdwSb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65F2222B2
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747845757; cv=none; b=PvmbgjM6hfyjyesPZcGBCsp1gxBAPv+lcWXaLEgrfvNMCS9vy56PhfnpnZyq1Y5Zr0QdqRGe3cv0R4pj9kc8zBGKp1vIDF2wt0UrJSo+vn6GyEzksb/7BGOtOSU24WcWRxj4tYBnTqLo/2tXfgAoq5zf+2b7H1cegQ7x5zA5xG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747845757; c=relaxed/simple;
	bh=Pr2iXeGarO2eWOWIEMNqbxZ1u9Fg64PXjfplyLT7Rjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=moDbnWEJHEOg32hZCV7jloiAN5uMoRnV3pAqI36gpH5beCyL9bSqXmmn3r4CFd7L2fj0y0mjmoSbNZYNq9Pn7vJH1hYgmcIvM3yrdKCLuA/4ybgotew9NuxXGtjG5t6KZGuvdluQJL2t7NBfISRKLE6q8o7bXxUoz9Uge9D/cfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SFwYdwSb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-441d437cfaaso43852135e9.1
        for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 09:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747845753; x=1748450553; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+rpUaNjQK4QRzCb0yqL+gVJP+k0UxVN5eahq6kD2BQ=;
        b=SFwYdwSb7mmBlrCDwGZ4E6vjDaTRUBeI35quOrI+wNGA0d6MvZeLT6bil3sli7lvET
         deRF6bOAYJGD0joqn0DytjZn95scnTxZvkrgX7o/Oz0nH0c8gpzexwCTR/MTAQ5BNlUg
         duCSS0RiHuvOlkuURF6+HXgnR7Mrv8pl0pb64qWBfYjfOKrf2pjFZXr/09u/rx7+/aqH
         1qEHRBX5fTFSCP1a600dNvnktg8ElWAyqIOJUgTplgo/WGr+XUAvphcmwj4+yxWGIvsS
         FtPKNrG2KR1d6JyWWuXnY1jw3l5O97fRyqVAhdAUfgvmH3lBOFhCmjUAHqUgLeNVOJ5I
         zw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747845753; x=1748450553;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+rpUaNjQK4QRzCb0yqL+gVJP+k0UxVN5eahq6kD2BQ=;
        b=dmPsmU7OF5jf9pwKkKy/l4ZRv9Blx3fIsVJSMHNhdl+vYsXdss5jPCNpHkJg70zPhN
         +N56pUund4gb68XMJ27gGd1N70fxoBKxqY0fry+V3/Y8QHy84gOLQlvfkcNW5R+yZcWX
         NxhVKJkN9SwvjizXL4psB0UrSQI6+daW0EnFz6bnhmOvAvxnrmyTRXgOKezR3EOPeHk3
         dBX2ta/t86Cvz/sh4lz321zS/zJiU9YDVQVyh+YUAvG/j/dy+hqNlZg++zfHs2EXAi71
         fGMcCKmyz5K6r4Ep0Aw8rL51DHiUvsH0OmoxUD/72v+ZiZEigYWwKGRqDMX05V5nkGcw
         6L2A==
X-Forwarded-Encrypted: i=1; AJvYcCU0BHWU65r4jYoxIlU2lZlW8dhr/z+7NrfVsQ9AvQ00bMrzqzS2NeX64cudJvcMKajlYJG6fbTHpf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlY3QBS/+c0nVXOinsTv8Ux2BrHSQfZKSghfHdU80bOiD6C5sC
	YFKdzxrl47VdLIacNj5Fml2AuTIJVJIfWCRyH3HIq2xaFoAbzHhQD8f7PDLDhgDjPC8=
X-Gm-Gg: ASbGncvEnbAeJrnRi0c6q6GH0EpWtyL0tbaFRJA83uNzE5FRgZAZtixGTZTDlmba163
	ffVcTQ3dWhqgi7Map8cF4ivHKuZ1MHoLf0sJNpeBD4cflT70CdXlHCiT6em35m85r1mqYaaOcjA
	huvnZ6ZHM4+G9fAJUFgTWdhjyICMe4XsVwAlFNgsLsHjDEVKidVrXWWzM4fzkAV2ev9qsNWITrY
	lD8WVIDYGtSSCEjFIK+wal9U8f8IDw5S7MXilmQmAzCvWtcG4UDM/6aOeGIFM1oIfeRNIG20rVb
	81ondmNUkOi/HG+uCFo2BHY9sBFrkpJtDQOo1ptghVrsFf8+cg==
X-Google-Smtp-Source: AGHT+IEeXDpnI4NwMcbKV1XjqWsxVe0v1X9IAk4NWkX0pUgdvpaaFVRgCRCctQA58qHtRm5Ki9qQtw==
X-Received: by 2002:a05:600c:1992:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-442ff039684mr199120715e9.30.1747845752620;
        Wed, 21 May 2025 09:42:32 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:9e2b:b056:8709:130])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442ebda7d2csm167543525e9.3.2025.05.21.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:42:32 -0700 (PDT)
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
In-Reply-To: <aC3/PL3jdGMVHX3n@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Wed, 21 May 2025 12:28:44 -0400")
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
	<20250505-pci-vntb-bar-mapping-v1-2-0e0d12b2fa71@baylibre.com>
	<aCugvDoKTflV9+P0@lizhi-Precision-Tower-5810>
	<1jecwjn2pp.fsf@starbuckisacylon.baylibre.com>
	<aC3/PL3jdGMVHX3n@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 21 May 2025 18:42:30 +0200
Message-ID: <1jwma9lxu1.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 21 May 2025 at 12:28, Frank Li <Frank.li@nxp.com> wrote:

> On Tue, May 20, 2025 at 09:47:14AM +0200, Jerome Brunet wrote:
>> On Mon 19 May 2025 at 17:21, Frank Li <Frank.li@nxp.com> wrote:
>>
>> > On Mon, May 05, 2025 at 07:41:48PM +0200, Jerome Brunet wrote:
>> >
>> > PCI tree require keep consistent at subject
>> > git log --oneline drivers/pci/endpoint/functions/pci-epf-vntb.c
>> >
>> > require first char is UP case.
>>
>> Noted
>>
>> >
>> > Align memory window naming with configfs names.
>> >
>> >> The config file related to the memory windows start the numbering of
>> >
>> >                                  memory windows (MW)
>> >  then you can use MW later.
>>
>> Sure
>>
>> >
>> >> the MW from 1. The other NTB function does the same, yet the enumeration
>> >> defining the BARs of the vNTB function starts numbering the MW from 0.
>> >>
>> >> Both numbering are fine I suppose but mixing the two is a bit confusing.
>> >> The configfs file being the interface with userspace, lets keep that stable
>> >> and consistently start the numbering of the MW from 1.
>> >>
>> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> >> ---
>> >>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 ++++++-----
>> >>  1 file changed, 6 insertions(+), 5 deletions(-)
>> >>
>> >> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> >> index 35fa0a21fc91100a5539bff775e7ebc25e1fb9c1..f9f4a8bb65f364962dbf1e9011ab0e4479c61034 100644
>> >> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> >> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> >> @@ -70,9 +70,10 @@ static struct workqueue_struct *kpcintb_workqueue;
>> >>  enum epf_ntb_bar {
>> >>  	BAR_CONFIG,
>> >>  	BAR_DB,
>> >> -	BAR_MW0,
>> >>  	BAR_MW1,
>> >>  	BAR_MW2,
>> >> +	BAR_MW3,
>> >> +	BAR_MW4,
>> >
>> > where use BAR_MW3 and BAR_MW4?
>>
>> This is aligned with the file available in configfs and what is possible
>> in theory with the function, same as the NTB function and NTB host driver.
>>
>> Stopping at MW1 because it is only one used in the driver would be weird
>> and the number later introduced would be wrong.
>
> Yes, but BAR_MW3 and BAR_MW4 should be added only when both was used in code
> actaully.

If you want to be strict about that then BAR_MW4 should go to the next change,
it is needed in the enum.

BAR_MW3 shall stay here because the purpose of this change is to shift the MW
naming by one. MW2 which was present becomes MW3.

>
> Frank
>>
>>
>> >
>> > Frank
>> >>  };
>> >>
>> >>  /*
>> >> @@ -576,7 +577,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>> >>
>> >>  	for (i = 0; i < ntb->num_mws; i++) {
>> >>  		size = ntb->mws_size[i];
>> >> -		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
>> >> +		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
>> >>
>> >>  		ntb->epf->bar[barno].barno = barno;
>> >>  		ntb->epf->bar[barno].size = size;
>> >> @@ -629,7 +630,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>> >>  	int i;
>> >>
>> >>  	for (i = 0; i < num_mws; i++) {
>> >> -		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
>> >> +		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
>> >>  		pci_epc_clear_bar(ntb->epf->epc,
>> >>  				  ntb->epf->func_no,
>> >>  				  ntb->epf->vfunc_no,
>> >> @@ -676,7 +677,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>> >>  	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
>> >>
>> >>  	/* These are required BARs which are mandatory for NTB functionality */
>> >> -	for (bar = BAR_CONFIG; bar <= BAR_MW0; bar++, barno++) {
>> >> +	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
>> >>  		barno = pci_epc_get_next_free_bar(epc_features, barno);
>> >>  		if (barno < 0) {
>> >>  			dev_err(dev, "Fail to get NTB function BAR\n");
>> >> @@ -1048,7 +1049,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
>> >>  	struct device *dev;
>> >>
>> >>  	dev = &ntb->ntb.dev;
>> >> -	barno = ntb->epf_ntb_bar[BAR_MW0 + idx];
>> >> +	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
>> >>  	epf_bar = &ntb->epf->bar[barno];
>> >>  	epf_bar->phys_addr = addr;
>> >>  	epf_bar->barno = barno;
>> >>
>> >> --
>> >> 2.47.2
>> >>
>>
>> --
>> Jerome

-- 
Jerome

