Return-Path: <linux-pci+bounces-41283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF38C60102
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 08:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43BE3B2F26
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 07:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A2419DF66;
	Sat, 15 Nov 2025 07:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld5LbLfM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9B82581
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763190154; cv=none; b=NrNUNFawgxohTGp6BR1rnoDUZngeBIn61RJpjtxt5fGM4PSvpzpKdSkcp69DT+VUhtQFjHansVElFBy46A9VKZafNuN5Yy29qhxlZHJnSYSNIyaeMJeiRLcaG3b8K++YW3ZQKHKwmr7i8+sNU2xG6SvZJVWEu6bxCPPHAaTP54A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763190154; c=relaxed/simple;
	bh=CPOZU5yfJpLLmtAWcddD3nJTrxdEdSCHQdtSXv0g/+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCzhVuUvMUJ23vqKNsCuCrcYM7xLF+9943mtyOy5069ue7mCj+SPA5pN7YjD6H08pk1mifUmKDwaefm71L1MwOEd3ygxxi/89/0ixkMAhs2BwssiU/YYulM6A8nlBro04EbVWsR6fDaspVWLpDiK3iKam5qMeIxVjQc6HJhzJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ld5LbLfM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-794e300e20dso2628041b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 23:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763190152; x=1763794952; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IOYSOoZ7kZHsHMrtVsrNZvrMCn7UoqoHGgR3M03FgNs=;
        b=ld5LbLfMN1eHpTdf5/8dApJG8Uvd9328R0yHiWvW96d4DXK2USeY0SJo9CGwKjjwZL
         cwLIrQrUzclorm14fQW8qz4TO7/XkRZyCa/J62eRnCDpACwnt7WPNJW2fHG0+9bwaPm7
         W9dgyijUhHL0bY8oAddRvijTGDH9gjvVNLJWAlMj8jjtIVCIUKgPuZcUskhgJEYMRlkf
         +VVqYPQh3qyywn2tBPoUc7B16ITiZxSpoAIqW9mW/LxoAJmaIeYrKSPCDf561tXL6gyy
         WhX3CP/eKehza3D279B7JqoN2BCTRVi4AI7Dytt3r+19xrxpYNNzZ9HMgDZovql3Kf8C
         mSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763190152; x=1763794952;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOYSOoZ7kZHsHMrtVsrNZvrMCn7UoqoHGgR3M03FgNs=;
        b=i8dqFW73x6lAUTpQxx4frEKu6OElLvxnPztx/MW54OcreDcFyOQtZo7kPBAJLWNqI+
         drvmQQhYChgZeChl08kN83KDIscYdnCSXPhGZCYfiodoi2owVrSxGDnDFvSBF4EM6zoR
         WuSXiWE/8d+hHiTFg6rPe5DxZeLO055FBCiqS1GUNIg4u4h02cmx0rhZmYSyIVmide2/
         29GMnngYoD33QsSw6RiGh0vc+sIt+snkzQiVuGWvEZcWn+74wW7uVYObxI++0SnCw+6x
         yYnc4cit1Zq2GFBN/MMZ+SKQZk1x6vfxRav4GvtDBuTWF5Vc53FFKDnwWV1tr5V0EIcw
         t8aA==
X-Forwarded-Encrypted: i=1; AJvYcCV5MLXDVFWGDFg3oqv+YRthsH5Eyv+ig0Oyruu/zsWIo7m+djh5tJQ/iDX/zVZW1/yfd84Nn5Ovse8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygMv6zw1fR+8BIK0N1edraR9hkfdriHdFjE3LUUxP1t6bR3ahJ
	prsEZaWnQx53oTmlbFHfvtsIJN4fr8Kkeq8mQFquAK/5Ihga5ceSIynZ6w4MB4AhT7Y=
X-Gm-Gg: ASbGncsE9N8FUjoRYgm75b0BNwiGCMy+VLUAm1z1qGys0wPtydh7Q+9M5Jv9NSM4kd4
	TSl261PGXUwRwMnSrrnN0MGWC9slMpZgdU9SIRiUzvEYeRLyJlPbBhCvgFsnT0MAhBmhzQBkS5R
	K9PMJUNwJviCed4qNWeSTGePM7uy3JsM7uC8b1nS5PuT8A+1nxkJBvdr39BYVEr0aQctB1Yh67G
	zfsHH9M/kmAUp/UphFuFn/jMtCBPBiupxoHUN8OegCvJHHAa1nsp7WkXo3fKJymt9cCpcqxoM6/
	rSslv4l3ZsEzMJkJvrU2Nh3Xlv0CJGtjZaWXJ6Tpld2SQo9+inTi+cGO/uWiR8Wg9fBBHimU4N+
	YuQJLQQto42w2j6a0MKXrq/EF5FiDxYGCoTfsBAAs3OQ1YC0zvcvjADxQEmxFmaF/r53OlAvwJX
	zgqObt8zoj
X-Google-Smtp-Source: AGHT+IF6Rm2Drf+1xlFmZRzPIXc1lSKc1tNyqq8bFT5+2d7X7z6WfhOem4D1nutU3J7fGxCS13ODNw==
X-Received: by 2002:a05:7022:b90c:b0:11a:4ffb:984f with SMTP id a92af1059eb24-11b411f05dcmr1444305c88.11.1763190151853;
        Fri, 14 Nov 2025 23:02:31 -0800 (PST)
Received: from geday ([2804:7f2:800b:a008::dead:c001])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b80fd6790sm4677580c88.10.2025.11.14.23.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 23:02:31 -0800 (PST)
Date: Sat, 15 Nov 2025 04:02:24 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	linux-rockchip <linux-rockchip@lists.infradead.org>,
	Simon Glass <sjg@chromium.org>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Kever Yang <kever.yang@rock-chips.com>,
	Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
	=?utf-8?B?5byg54Oo?= <ye.zhang@rock-chips.com>
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <aRglgNL5eumu4XbS@geday>
References: <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
 <aRLEbfsmXnGwyigS@geday>
 <AGsAmwCFJj0ZQ4vKzrqC84rs.3.1762847224180.Hmail.ye.zhang@rock-chips.com>
 <aRQ_R90S8T82th45@geday>
 <aRUvr0UggTYkkCZ_@geday>
 <aRazCssWVdAOmy7D@geday>
 <e8524bf8-a90c-423f-8a58-9ef05a3db1dd@rock-chips.com>
 <aReSPbRxCgdNRI9y@geday>
 <ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com>

On Sat, Nov 15, 2025 at 10:21:28AM +0800, Shawn Lin wrote:
> 
> 在 2025/11/15 星期六 4:34, Geraldo Nascimento 写道:
> >> Another thing I noticed is about one commit:
> >> 114b06ee108c ("PCI: rockchip: Set Target Link Speed to 5.0 GT/s before
> >> retraining")
> >>
> >> It said: "Rockchip controllers can support up to 5.0 GT/s link speed."
> >> But we issued an errata long time ago to announced it doesn't, you could
> >> also check the PCIe part of RK3399 datasheet:
> >> https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf
> > 
> > OK, I'm partly responsible for that as author of the commit in question.
> > 
> > First off let me say I do not intend to send any patches setting
> > max-link-speed to TWO for this platform.
> > 
> > I understand you issued an erratum, but are you absolutely sure about
> > that erratum? Because my testing shows otherwise:
> 
> Sure.
> 
> The reason is that Gen2 is merely functional, but this does not mean it 
> is 100% production-ready. It has some inherent issues that cannot be 
> resolved, which may lead to failures beyond imagination. Even if the 
> probability of occurrence is as low as 1 in 100,000. I cannot share 
> further details. Therefore, the official documentation should be your 
> primary reference, rather than relying solely on simple evaluations.

Hi Shawn,

indeed, the situation is not favorable and we should strive to make
amends. I'm sorry I based the commit on outdated information, I was
none the wiser.

What I propose is to add a comment to driver core saying that path
to 5.0 GT/s shouldn't be taken and users are strongly discouraged to
mess with the maximum link speed in DT.

We deal with corner case of helios64 in another patch and make sure
there are no DTs engaging 5.0 GT/s.

This should close the loop-hole.

Regards,
Geraldo Nascimento

