Return-Path: <linux-pci+bounces-25821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792DEA87ED0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 13:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0EAF168E60
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 11:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02366298CA3;
	Mon, 14 Apr 2025 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZb9RHfL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2260D2980C0
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629335; cv=none; b=TkKseE0FlFnAhJBrEKSHFQ2Y9KbIwRRHs2fONCNjdWl3yF/9eqXVGA1NS0fnHGVskAwMjE5wRJKFojgVD1lfSWhDLk0vcU+9vY2pYCWq0vykW5pkpiix32hQv2iXUqMfesw2UHKnr0xBoGnUW+JcKt1Twp2dE0miIoBS0pdCyN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629335; c=relaxed/simple;
	bh=afDS7rfeFrK9rl7VbLwnwnMc3kAcEi8l5jjlmmNbRkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVUOnFK/7JJNaGOD2fLRhBkrC2I1rDqhAFcNS010Vz2TbtrQ2k4YcLuJH2ijrHbgXMTmmW5sYaLskPT4O3GpbBthkX9JCmnXJYpjzxHQ5Rao89+vtaxGrMeFsHG6Rg2z8yyuI4G8rT0+RqoBS9GXlxmbU9D5j+/ArnVpOFklnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OZb9RHfL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736b34a71a1so4826982b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 04:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744629333; x=1745234133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RQlcYD4asnsxpVdwQG6h+GjZzibJklswImMXTXM/EgE=;
        b=OZb9RHfLq7x4nbfoyu3uYwfKiztsO4hc4Ru9AMlohY1UQYBsE73iY+XnYiG58wRWqE
         L9IEnKiYicxYPSedMg7Qgyz7JP1gZRllAMPehpERKeL4hfxBVBiAE2VNf5fDYdXbIFkA
         ub7bOJeO1V3FM4Rr0G0gxm/VTLy+vsAPwuzKF30+04Q7NlXcYvCMxk+dcKRFDCr3PrSt
         4HtUJSycAmZO0tghMsySsC44NJvEHD/U3yuAmKqUGIXhK6Ry9TDXBbmz3rjt8ZEdTmfb
         t4f7WfAzY3rhcC8cif8L0TEecjkIObzAw41B+ycA6a9UrCdL7WOcT2JxDvRwE61KTuNv
         GuIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744629333; x=1745234133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQlcYD4asnsxpVdwQG6h+GjZzibJklswImMXTXM/EgE=;
        b=NWv/8TKtGsr2tPsEDOXeMVvWhcfA9B0LxrxMJq+urizHgjmOTYXwyaE9HBWuWpNCOe
         VEvzWLlJipUrKa1PIY7feSbaHFE1pqnz1UOO84WdkY+xPY8d0GMVvlsHTjLrzgxKySy7
         57la1QJ011Fr9kbyt8CZpkU27I4u+29+TPv4bFQrhJinC7HaizpN5irM+HKYxRZOQ5C9
         XDptS7la8i2ocjJcI/K3uPanLpkpckisXUuhGT17KDnUvbCk5aOnQUWZg0ghhwcEkXHV
         6mDp8BKW4kvwxU7GWGhumKVFS203oRbFnE+P96j1/PPsxGPLLUXSdFkFAAiixdRZY4QV
         GTaw==
X-Forwarded-Encrypted: i=1; AJvYcCUQFATxRYBMT8CY6B1b+PuPq2xgwJpI/K/dyDgPwEAcMqsjB+o5SRG26BowoajRB83Iy/b42r7JiOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAF6oSamZqKqOBITELT1usCjDJ00cLcNl7A3zdbBlSaAByNuZ
	8EeG/H/plwqL32EQfrM1qQD670aJSXp9YjFDK4VPCG6xXJ0x7/+NN/pRmjkx9Q==
X-Gm-Gg: ASbGncsDwZMOBnT8SKQd5LJjGwbMRpdAb0T/5c3IOSL97zW7gmU7ndDLk20jiEmu2OB
	WSHvX/YdceUaB3SXTUBkwjoHS2DvYQd8lvfqAZNJc3/6q0kZnA7VxoG5plMzJgqtpwRF/sr2Zhv
	XPwfZhKlYtEiskE8PvZIiDuceq0Zdka9kfdvIIbn/Lvu8oeju8gq9sh/0v9GFeFph6VE/SU1NoJ
	5f/4I/+twhWRajhh+80jMvNoENbCDe4R9akKyUGWCyYu3HCGsmWzHO/M5EWARCQZm3BRsem9w44
	MkKF2eo2O/+NVLaAujGcTpdtIrEa/YcQhuwmL30OWM4qaNqmTu9B
X-Google-Smtp-Source: AGHT+IHLmEWm+AyUgC3aZXfK/APx9iAwvnZ4/R7W9g5gd6twWGbVcm4JwjPl38NL98UBnVMWqLwbnQ==
X-Received: by 2002:a05:6a20:43ab:b0:1f5:874c:c987 with SMTP id adf61e73a8af0-201797a43dbmr16442336637.15.1744629333130;
        Mon, 14 Apr 2025 04:15:33 -0700 (PDT)
Received: from thinkpad ([120.56.202.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0817f4fsm9032010a12.13.2025.04.14.04.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 04:15:32 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:45:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Remove PCIE_L0S_ENTRY check from
 rockchip_pcie_link_up()
Message-ID: <zansaj7wgeydqo6qqvczlkkoll2tcpay4acvjd3idjemrbrbw6@2hqfmkfsug5o>
References: <1744180833-68472-1-git-send-email-shawn.lin@rock-chips.com>
 <Z_YwNt6WUuijKTjt@ryzen>
 <38e69551-cc40-11a9-191f-de9a193c5e51@rock-chips.com>
 <Z_Y7h1vzVCCEiXK6@ryzen>
 <gogw24yg4lfq77ime7qyurvkef5yvmkkwjxo6xch52fbszibax@diaxredvtcrh>
 <Z_zeERoDtZ52kW0T@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_zeERoDtZ52kW0T@ryzen>

On Mon, Apr 14, 2025 at 12:06:09PM +0200, Niklas Cassel wrote:
> Hello Mani,
> 
> On Sun, Apr 13, 2025 at 07:54:28PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Apr 09, 2025 at 11:19:03AM +0200, Niklas Cassel wrote:
> > > 
> > > It seems like we should really add a warning and a comment in
> > > dw_pcie_link_up(), so that others don't get hit by this hard to debug issue!
> > > 
> > 
> > Right. But I'm also wondering if we should use the 'Data Link Layer Link Active'
> > bit in PCI Express Capability for checking link up. Qcom driver has been using
> > it from the start and there are no reported issues. We could add this as the
> > first fallback if the link_up callback is not provided.
> 
> Sounds like a good idea, but from looking at:
> 7.5.3.6 Link Capabilities Register (Offset 0Ch)
> 
> "
> Data Link Layer Link Active Reporting Capable - For a Downstream Port,
> this bit must be hardwired to 1b if the component supports the optional
> capability of reporting the DL_Active state of the Data Link Control and
> Management State Machine. For a hot-plug capable Downstream Port (as
> indicated by the Hot-Plug Capable bit of the Slot Capabilities Register)
> or a Downstream Port that supports Link speeds greater than 5.0 GT/s,
> this bit must be hardwired to 1b.
> 
> For Upstream Ports and components that do not support this optional
> capability, this bit must be hardwired to 0b.
> "
> 
> It sounds like the the 'Data Link Layer Link Active' bit is optional,
> or at least optional for Gen1 and Gen2.

Yeah, we should avoid relying on it. Thanks for digging through the spec :)
Really appreciated!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

