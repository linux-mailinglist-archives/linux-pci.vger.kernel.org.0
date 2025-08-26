Return-Path: <linux-pci+bounces-34703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94791B3536A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 07:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876951B622C6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 05:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02C22EE619;
	Tue, 26 Aug 2025 05:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OCZe3bDn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A92F2E88B0
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 05:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186571; cv=none; b=J25oKdK9+2wlbgdgzRqcFptPB9P+PnQHjGDIm3uVu5sjC3IE9SAFv/mBoQfAH7wkyDwl0QxjYSD1lx0iD+9SAKE5RGO62n9n9KQCEX1upWZQCOLOuDTZifSXbCBiL8xDiZJ/y9A9d7LMkL3vlnd4e/MxX2VBn8V3yhB0yIBYk0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186571; c=relaxed/simple;
	bh=Vc8HqLk1oNkBJVvIOq+E2XUgPQ4z9TxRdkU64UpWBIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqtE9AKt4549a7XHFnmMVRil/cGHDiqg40ElPe1e2/Z9CUVC8NU292IMpaYqWB5s3eP7lx17Kzzf/M7eE8vdlZToEgQnUEOGcSfHcUL66Vv6E5D+mdaWBN23MTN3aAx/82awtru0Jsd7zCvlkeOn0s4aouk8aq5mm3HU/8ndTy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OCZe3bDn; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4c1d79bd64so1631119a12.0
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 22:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756186569; x=1756791369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+T8E42RqnU9AlmkM6EHxWJjzsznN4WvgoYoMrFYbi0w=;
        b=OCZe3bDneGBpEZ6VDbisda62W5hTC6i4U/27+v+8qx67MI5qdfNlloEr8QF4XGZ9ua
         /SZY6tnaifxaLsUuYUCZDjH0x4opJ8hzF+/HgcpPzbc/UCU7iyWv4SUGPYN+W47WqU6b
         vsH2uKvYlwsHDrJahQEyzoDWNFeUGWRKdntYoDlMlJx7AwipCuJ5dk7p3gNT0xGScDEk
         q1aD0oBeOw4KurRQ6jsuX91ZRB+1e8LNiK2f+hO9/Zw03e/IzhpQQ/MwkuXFu1v03gwh
         hE7sXeThdVaqpMuXZM3jypg9W2XejQBIaddpRn8BjE2g4IKiJJcLEmfL40w7OfEg7XRm
         uPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756186569; x=1756791369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+T8E42RqnU9AlmkM6EHxWJjzsznN4WvgoYoMrFYbi0w=;
        b=wQtnohIhEB+/i+jq3INsY9RJD/FDGXOp5HHuxwPD2yfMRYKbC6QVHDUP0ntnVDGF4V
         7iEvPJyZrpa65UZI8Gg5g0JoO1Zfj3GHtzfTGHWh6Qr4XU4rwdU/9eqAjJXAwbWCfHti
         V2pOzZ5aoonO4v/WZgf+DqJXvq5nuHV0CIJUrWdpPua44T9LRYj0yUeBUBcQLD+4aTDY
         UrUg3HTj7oOCT53F6t5imV0RcapAwq5PkiPa5SCWWtfy2cK8+iXTXhpbLruIJMKvL5j2
         nU4ayICkQ4vuIvyK+QU7C8759dxuamOFjMsnkU555eA71heDhUOUZtimtB9U9QJm4vri
         lpZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpzjWH+TXa4dgPOmJ3limcfQF6+aOnW+theKO3yGTluo4TQxA37NDOSRNAdDu43DFnx2IdyPD78ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy18rO/UuKvfj/ojaCcft0mhbfhKsSHIGeuBeotjibms1YQYMFu
	clXMSdPAie8RcBHks3TAhFBeMnH0SXC/Zz80sFSCcrCoKvEsSGm8g065UDU/OP9bWHU=
X-Gm-Gg: ASbGncuGnd5K665TkoMOosNkik77ZjFOZdXtlddbfe2Xy03KkCxQrfg+EGttc0xxoRA
	ArhCKC17+jNvti9f7VGin1DJOSNp5r1B1DyKSmPOjtEA9ax+/a7wIgB/oJYJiJuYuLItJhV0ZDQ
	ehgyDxe+lBYlt8+DST3kLqzyBTCQOxWMHulAQTF+hbXB9EY0QRHHG9pVTfOeMuJoCycUACXUZ+a
	y/lcRlDnmx2K8icJWhxr1QaFyk7+nyieFHIAk/osKCYyDjIntnKw5sLTbqxd3A3BRbdRyKZ6bOI
	TUtAQfYfCdcTjH3hfCy3k3CEIMNFOFhWNcUHyx32XjvXrNl7kkgqB+19I4+aewXcIxkc0moA4dI
	93J1KjTeoz/+poRNvE90RyEmjy0LU4P48NtQ=
X-Google-Smtp-Source: AGHT+IGfTwYFjftBJaGFXjmow3/nCWDDyflG6zroy2YezNtKf+oppQf+YsobL05QgCGAZlmQXU0dtw==
X-Received: by 2002:a17:902:c408:b0:240:2281:bd0e with SMTP id d9443c01a7336-2462edecaa4mr206705865ad.2.1756186569430;
        Mon, 25 Aug 2025 22:36:09 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246ed91ee20sm32288035ad.136.2025.08.25.22.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 22:36:08 -0700 (PDT)
Date: Tue, 26 Aug 2025 11:06:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] OPP: Add support to find OPP for a set of keys
Message-ID: <20250826053606.zktmwgfdwymizv6k@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <aKyS0RGZX4bxbjDj@hu-wasimn-hyd.qualcomm.com>
 <20250826052057.lkfvc5njhape56me@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826052057.lkfvc5njhape56me@vireshk-i7>

On 26-08-25, 10:50, Viresh Kumar wrote:
> On 25-08-25, 22:14, Wasim Nazir wrote:
> > Kernel log:
> > Unable to handle kernel NULL pointer dereference at virtual address 0000000000000016
> > ...
> > Call trace:
> >  _read_bw+0x0/0x10 (P)
> >  _find_key+0xb8/0x194
> >  dev_pm_opp_find_bw_floor+0x54/0x8c
> >  bwmon_intr_thread+0x84/0x284 [icc_bwmon]
> >  irq_thread_fn+0x2c/0xa8
> >  irq_thread+0x174/0x334
> >  kthread+0x134/0x208
> >  ret_from_fork+0x10/0x20
> 
> Hmm, this happened because it is possible for the `opp` to be invalid
> (error) even if `_compare_floor()` returned true, if the target key is
> lower than the lowest freq of the table.
> 
> Dropped the patch for now anyway.

Can you help me testing this over your failing branch please ?

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 81fb7dd7f323..5b24255733b5 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -554,10 +554,10 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
        list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
                if (temp_opp->available == available) {
                        if (compare(&opp, temp_opp, read(temp_opp, index), *key)) {
-                               *key = read(opp, index);
-
-                               /* Increment the reference count of OPP */
-                               dev_pm_opp_get(opp);
+                               if (!IS_ERR(opp)) {
+                                       *key = read(opp, index);
+                                       dev_pm_opp_get(opp);
+                               }
                                break;
                        }
                }

-- 
viresh

