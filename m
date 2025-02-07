Return-Path: <linux-pci+bounces-20859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7671A2BBF6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 08:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C871886A39
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 07:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD9B235BFA;
	Fri,  7 Feb 2025 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQMvUHgv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513DD19A298
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738911574; cv=none; b=r/Id+Y7BO9rn3lA3tT4PCydhOmh+8xTNxplv/lZyxy/0xirQ2a8nZoGi93wLTUcusTr9AGARHRYSjkjhkumRvhycTlj6PZsBSGOtYOaLTabI9XhdlxKbN2iiTaSxAB/rL/4MYQkhj7tkcMiywD/myafnssQ3NZq0SvP97HCWZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738911574; c=relaxed/simple;
	bh=6kaouR7oZgNLN17kEeH+Pxk7KmscGY+LGC8DZcas6YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l5dYibLKgcD5MqkMosFFXe7XFyJnwQIZV4ILMuPlS9kQl6mdkuQgcZngM1lEzFM6owGoygGaNwKtu+OLYEEX/sNXAju5K7tQla+t9gmYKDRl4ITl7x1quXhG8K0rIGoYC7atp/u2IADNvbt9kls08lIxHJrKrpHNsvXdtKZ8FeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jQMvUHgv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166f1e589cso44284705ad.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 22:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738911572; x=1739516372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W679lNgXvpPBehgEqKaCNaQXg+NBsATD/PMGTi0DCZQ=;
        b=jQMvUHgvhqshc1UDYlbmrn7hqzKAA/xWfHWqExxrt5kGXZIwAatmqk4K8bxLgf09CD
         BI1of/w7CPPv2OC/bV20MX0bbYP+miLMF3LFD74xrAmheqJaBM+1O3bnkpDcaMXq/Y8+
         iiF8IdWi1XlT05eFIt9/p5K04KuodMeWbf7F0zQ8v704jds+1JU32OG8lZJDvppe8o7B
         4gWcuNNImslOa7CMbEVomrRbcDzfnw55BaxYVl8LmyqUMrJdp1yveAOUsXQzTbKhXHaK
         6Yd1HaGVyZ+vwCtKTJvElFGUS46Lc5MkB9/8dWHmgnIMTqhax5/0790QcNk9n34GHefV
         YN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738911572; x=1739516372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W679lNgXvpPBehgEqKaCNaQXg+NBsATD/PMGTi0DCZQ=;
        b=Qs3tmPPm8apXkBTEx7lxFeMfCJsnR568RyMTNqCvwX63a/fVmYj00lHX36NUUkB7Ec
         A9RW1ksXvy88FarZCvOuBapzYco+SGxZwdGUoFZEwi0vjjoDjIX/KZuoRHXFctNakjVK
         VNMiTQwkg+FjOjoYjBKEvJwFbwKS7nKaHrxXzyl9PIuNdfa8ulcoz+PeU+mGEJi2swiH
         o4KfYAWYtwWcDNW/LW+sSShbPXr9Nj6+ZT1x+PGuZVCUQtse9xlwsG7X4cVrnGHqOauv
         sxdIQkYb7Al0euCVNZdqyeTn20cbdZH4aBY1L7qnl6rfGRYa562QYEHV/3RYbAqSa6S6
         Kudg==
X-Gm-Message-State: AOJu0Yy25DIrdk4PH1uim/rfyy0C0k027le5vl4skr3vl4S7/o84tk96
	qffRd9kakW18cubhBkJS1EAdl1PPVKfd06Kuhy1b4Ya4Lks+gFsCYfJKpoUWiQ==
X-Gm-Gg: ASbGncv9hUiWCjLUG18Ilfw7ZO+EOa86kHmDVM+Q4JVKnEF2cUy4GzjHysYOAaQCCjt
	1+3MQNA6LGai97opG8kDwqnRpa37THlyhBZKceDsrSHtpXlpGoLHcHrpAFSilxt7Bg3DqVJdOHR
	7jvPGxVSiqKVbdPXGusZ6gAOSRwn4eemMu0iJ6haiC0Y6oLL1QU/USA20wlSRO/KfqYhqjs7pTx
	vl3yKi1SC2rHCAkiu7CD7wQ7bPTeHQB5ukR5uXeuHLsOskkXKzDDq3KXzNOJqSM6mFuEa12AhKu
	BubYHctJXv/gKB0RvTI0297SSw==
X-Google-Smtp-Source: AGHT+IF2LpdEJOzHM/r4B4JdjSv0QcjVX0ilM/S1u0uF9+87CF7k8lNOP5/Clx4J5u89poWFyLFT4w==
X-Received: by 2002:a05:6a20:43ab:b0:1ed:a4e2:8631 with SMTP id adf61e73a8af0-1ee03c00212mr4065052637.38.1738911572638;
        Thu, 06 Feb 2025 22:59:32 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51ea79a47sm2226085a12.76.2025.02.06.22.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 22:59:32 -0800 (PST)
Date: Fri, 7 Feb 2025 12:29:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>,
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [v8 3/3] PCI: amd-mdb: Add AMD MDB Root Port driver
Message-ID: <20250207065925.6u7bemyn2aireiii@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60c5504d-341f-4ce5-b337-1eca92a9506f@web.de>

On Fri, Feb 07, 2025 at 07:39:03AM +0100, Markus Elfring wrote:
> > I don't *really* like guard() anyway because it's kind of magic in
> > that the unlock doesn't actually appear in the code, and it's kind of
> > hard to unravel what guard() is and how it works.  But I guess that's
> > mostly because it's just a new idiom that takes time to internalize.
> How will the circumstances evolve further for growing applications of
> scope-based resource management?
> 

Please ignore the comments from Markus.

Reference: https://lkml.org/lkml/2024/5/20/724

- Mani

-- 
மணிவண்ணன் சதாசிவம்

