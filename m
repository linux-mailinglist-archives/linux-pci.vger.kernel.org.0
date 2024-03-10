Return-Path: <linux-pci+bounces-4713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B93877814
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 19:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065181C20833
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 18:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC639AF4;
	Sun, 10 Mar 2024 18:53:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0186139846
	for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096785; cv=none; b=nnsPR9kpo4vfRHzdpo6dCU4rlKh+2xyO/CKTLdFR44HxZH0PArm5d2zLfrN3zERWQOurT0nBH663DtOhFm+2iE0Fn7GbnQheI1wf/YFHjWE/SoALVhziY8+s2LBjnRJWYS74zGcQFD2eVnUVUc7l2t2o4TLHjoOcsf76Fqfw2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096785; c=relaxed/simple;
	bh=1kYPjXDqQGIFPMu4MecNiOjbfkTDNkJ3Y7gA2yJ02aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRQlz9z8WfBfi2DiSDoOWH8Dc+nxUxaEDqnCZUFdpvEXDZySX2L5pdD45M7qH5T+aDjklQmlrpJKV1EEpood6xGjeavh20+GT1qpShW/WpsRTx7JEcYmxLhgsMoZOP74Mj3KNTn72q94EN29PvsfC+NjS5pFOtcGo/4tHVPMspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e1878e357so2315888f8f.3
        for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 11:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710096782; x=1710701582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igI6H5ub6VeR1Nq6H0m9hm6/ry8OZDbHkF7a8DDisUE=;
        b=m6LLSycDXgP+sgox0oAefTqZrKl0fSiMnUPWDz5KAOGdz59lezq/gJ+IQAUFGmhDaM
         PIQ9hGQGmh/mrj8l70hJWzBPjoAcVNnNiacqZvZFpXboZCJMYPYUUxyVV9bG2hm4HwC3
         SpAhPrqCtymbBwICWv8KmWOxu9ZQs/jMO8M3bmNy5IiKebkAW/2rf+rgulht2/VLksVi
         2czyaaFWNg6Gt+mWf2YPlx1NoSzn9YVBur8tBCUtd363U5kH3ukkZNSRAQoqgzodxQ0u
         VBRUHTBBz0CNwHgGp7DZkEKvWJ/zaBiXq1+6qSo6u0VtB0j72Wmtb+PQc39v+E8V2//O
         IIJg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ke3ODsCMAPgccdjbUw7LSQkBqoHmB6bKJlIC2+Y4kgibqALfxAtAU88Ce1SGR881OytyDrFmFJcBFWijdXFjS6cFdn0RHcLe
X-Gm-Message-State: AOJu0Yz5RXQfe3TgI7PNGnHp6sP7FPKejLMWz9AMcsxrhvEDTNpXA3yZ
	oqCX/Te202WOc4P+STF4sqFeNmb8xH0/i1kItfSbCyVeGVZ8gDdX
X-Google-Smtp-Source: AGHT+IF388XCbcZ5AMbf0pWlNaIy+l87cQryW50iLMIw+1jhVpQEoBlf4kvqBkcQmD4OUTk2dRy+Zw==
X-Received: by 2002:a5d:644e:0:b0:33e:89ad:efbd with SMTP id d14-20020a5d644e000000b0033e89adefbdmr1857998wrw.53.1710096782230;
        Sun, 10 Mar 2024 11:53:02 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id y3-20020adff143000000b0033dc3f3d689sm4479717wro.93.2024.03.10.11.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:53:01 -0700 (PDT)
Date: Mon, 11 Mar 2024 03:52:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix advertised resizable BAR size
Message-ID: <20240310185258.GG2765217@rocinante>
References: <20240307111520.3303774-1-cassel@kernel.org>
 <20240310130443.GC3390@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310130443.GC3390@thinkpad>

Hello,

[...]
> > Fixes: fc9a77040b04 ("PCI: designware-ep: Configure Resizable BAR cap to advertise the smallest size")
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> If you happen to respin, please CC stable list. Otherwise, Lorenzo or Krzysztof
> could do it while applying.
> 
> Cc:  <stable@vger.kernel.org> # 5.2

Done.  Thank you Mani!

	Krzysztof

