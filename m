Return-Path: <linux-pci+bounces-12575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26724967B82
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 19:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577731C20E88
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75317DFEB;
	Sun,  1 Sep 2024 17:34:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD5728387;
	Sun,  1 Sep 2024 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725212041; cv=none; b=PB8YBpWbknT/iVTb9zLDDOMGDqJclLI9Tt+QR/duClQqJruC74Ed43FZLtycDqbpQ6RuLjXcnrzF1uSohuxYD3v8wZFkCazB3jxRyyH5SuJP+C4DGxu8vuv1w/zJCauSVHBH7U3EW4w5r1GCz24T03FzbmjzTUyoz/4lXQRzw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725212041; c=relaxed/simple;
	bh=PzDrXFfzqFVdCV2JfpY1TCCOml/OGOWPD8/E2HMkxiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUaBKH0I7+Yukv0WnSUmX731Te8/NASPFObtCmbVljItiSYGe2DtXdR72puC/pHeMnBGFstWxUuUrhaBCu9iD2qb2lBCzAbncuQC9rzRB3prN3nY/Ozbg/GVe99P9Q5B7x68+6N8QA7UNKcw/CfdfShOr4U089O3ANoYNwJQ4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7141e20e31cso2877830b3a.3;
        Sun, 01 Sep 2024 10:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725212039; x=1725816839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYbqkAtoq8ECBqJqS2WA0sHMNuKw8v0jwauE2w39rHY=;
        b=ii6kYArK7dR9NhoLXKanlwUAjjPIPrG3Tash9UwdGkKGB8s+c99sIF8P81jZwfpWsS
         Y+okivLCb6jA37e0BgOGct9WkFKhzb4SkWoxa4i36XaNy7ahH6YaVNX4q+KCf2N1ARz1
         e3VL0tBbR+IhJZYZm8nU7jFfyJPojHL5pMR0RKXj+sczjoGnkOk91a2eqVDwuE5RtJum
         TUxfqFG30IvrSmwaGNkSbtlNARNKd3PKvrTl9+vSMzNgLILbDbeaH7ndKBAH6ArUN1Dw
         +AgmcfaLmml+MMU2n96mm1sQ6XLFNA3+zCGFJUr+plL9J8UZzpUeMFpyQrxq8kToRnlp
         STqw==
X-Forwarded-Encrypted: i=1; AJvYcCUQRdbcxF+lPAilRa+GnP2NHnfXMvsCkwVHz+NMHYxQZ1G4ScOBCdy1IQEezydQATBMDlWO96vWDluJuxeF@vger.kernel.org, AJvYcCUhE20kRkSHID5t7ezMm59zDvcRGwB9VqyqzPl9n4CEu2MXo9KEmJbRZI0UpKc6dw3aFyY/4CGp1I3As55FYeY=@vger.kernel.org, AJvYcCVCRMoIv69ZlCZGraF+Ynw4EQLSh+K+nmupu2fYH0U2n0/OMXjsQPGhAT1jMkbZkctP+9e/zArDVCZBSO19KXjvAn4=@vger.kernel.org, AJvYcCWsTA53gOTqN5HthhD84cDchtS9SZTaCR9Yh4Gkc+bhlcc8tQtAnhvuopVwqDO+stSAo8jQMGudFSEK@vger.kernel.org
X-Gm-Message-State: AOJu0YwarxmhzqJ1XZPX6JGYbhatqAMDVAW+JA8pVFQ0ksXwWZoIV8om
	Y8K7Q5LqiSWdOSLSnE6AziWe5MOVl7j0DY4gotAkbFtNROlZCTXW
X-Google-Smtp-Source: AGHT+IEFQMytQM6n1pdKGwJuMZ05wwyEdA7f61XnLpDQzaPQVkTiJH9ySeXrhOSznpoV8xzQYWje1w==
X-Received: by 2002:a05:6a20:b418:b0:1c6:a562:997f with SMTP id adf61e73a8af0-1cecf757f5cmr6024916637.42.1725212038844;
        Sun, 01 Sep 2024 10:33:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205439dadabsm26453685ad.166.2024.09.01.10.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:33:58 -0700 (PDT)
Date: Mon, 2 Sep 2024 02:33:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: rcar-gen4: make read-only const array
 check_addr static
Message-ID: <20240901173356.GK235729@rocinante>
References: <20240822205941.643187-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822205941.643187-1-colin.i.king@gmail.com>

Hello,

> Don't populate the const read-only array check_addr on the stack at
> run time, instead make it static.

Applied to controller/rcar-gen4, thank you!

[1/1] PCI: rcar-gen4: Make read-only const array check_addr static
      https://git.kernel.org/pci/pci/c/5603a3491b36

	Krzysztof

