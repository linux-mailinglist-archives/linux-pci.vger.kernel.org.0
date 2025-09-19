Return-Path: <linux-pci+bounces-36480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22CB89DDC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B359D3AA334
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761883112D6;
	Fri, 19 Sep 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R8pe6gCC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="akm/prIZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6AA304BD7;
	Fri, 19 Sep 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291710; cv=none; b=LxQED8oHFz/rCFw+/GTyxoVsd9gBsSAznVenGft12YpNzUeP7TnPLOPog/sl/Eas4bkQl060eb6Vvci9e0+hYCHjdXnsxmxCpVYkL/nAoO3yzob74CHq+3ufGNoacbGdWBwKpjJkGgOLHRMozXOHnD+tbT6MsR01iiCIsR21nGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291710; c=relaxed/simple;
	bh=ms4BSYg24WtCv2INcR+zp+YTYIeJmo8eegi09owXHs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MaqpXdtvQGcOr/gbPPsIUVxivgUKkyUf+pr5ftwcV+KBwVINAvl7IHDXvgWwKkstjR24BdIzPgXAHNalmLMqV/gIVf5zNp/PGlxF751gOx/4GQevNKivvCQtB7T9slSXKhYkiklywHF2au+eNvOgt9r4GRkMhY9XcC2Ta/imT3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=R8pe6gCC; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=akm/prIZ; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cSvp23QLFz9t8m;
	Fri, 19 Sep 2025 16:21:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758291706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0C7x6JSiZLAkwvCSWBHZvTvW/DiXlBc+kXSxhWoUgw=;
	b=R8pe6gCCGeDL2wo0kTwLE1zijwMSOBoEH0c9XqkDRw0VHMvIFMxXm8zoyjz8+A3pPsDQFU
	NlvqV+Un6uNQslFcDBLRGwx9irWCQvA2/lql2CGqZYiWBfdcgSpLdXP/3AN18Z9nIQtY4E
	fhEzxooRjwzL3AhPHqaGVv5HJXPNdSlU/8NPgIm0vqXMEn3GPXdxYQaUa1For0dcoR1ph3
	NZYps4V27uLiRzmz5Sf+74c5meiEVrEe+Gz1TOnZCDekcn6hYm0d1K/TsnLga2eZ0rzHH+
	lL6laFOXYAdQqy7qVXajxroXmYmBl3WVHa5rpWEp2hzP/WyT5sEj8fVE1CKD9w==
Message-ID: <77ca101e-28e6-477f-b9d0-1ac7c154db33@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758291704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0C7x6JSiZLAkwvCSWBHZvTvW/DiXlBc+kXSxhWoUgw=;
	b=akm/prIZnnwUCyNfC4augwJO/FS3+E/QLyPN8jBil1w4sM05FF/Uj1zQ9ha+Z8G3Ul3WMy
	F/lGM5vLjjZVOp/FIqsP9GyE6OyrzR22waVdmiCwlG3A7pCEnq4rB8Z1Nwhs4plXIIVhYW
	YxI0sdHQDHXKwjbKlfReF32Sj0ikF1X7PcKf/v167VimPuIq773DfSsXghfF6AKS9AG9a3
	FJ8ImcqP22XDB/Ihk8AbYm4WpAnJgBgA/oZgmMp9FnxSo2DcTi87xUDs1VgNPPp2FB8CWk
	O7cCvo5mtzxloUooes71DasQZQbm6xzRrOEemfI+2tL91X0pcibZzc9N6lREvg==
Date: Fri, 19 Sep 2025 16:21:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] PCI: rcar-gen4: Add missing 1ms delay after PWR reset
 assertion
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, Manivannan Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-renesas-soc@vger.kernel.org
References: <20250919134644.208098-1-marek.vasut+renesas@mailbox.org>
 <20250919141340.GA709855@rocinante>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250919141340.GA709855@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: knpdzgfe8or6h4y5dehwyp8jmkk7hfhb
X-MBO-RS-ID: fa1fcb9414c86bcf4d6

On 9/19/25 4:13 PM, Krzysztof Wilczyński wrote:
> Hello,

Hello Krzysztof,

> [...]
>> Fixes: 0d0c551011df ("PCI: rcar-gen4: Add R-Car Gen4 PCIe controller support for host mode")
>> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Missed a tag from me. :)  But we can add it when applying, no worries.
Sorry, and thank you.

