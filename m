Return-Path: <linux-pci+bounces-36080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F464B55EE7
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 08:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B421B23B0E
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 06:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE662E717B;
	Sat, 13 Sep 2025 06:17:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1388C72631
	for <linux-pci@vger.kernel.org>; Sat, 13 Sep 2025 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757744245; cv=none; b=P2hriWcQMXKRb3ICPA8XoDYoKX7tpfZu8xPzD3aMVDQ9bJ78DvtNynrQyQzmCMa928b/hMDD7N491t1OOhfQwhLu7ikAgziqL3dBajuUbl2iJ2WqRX4dD9mPNaIji3IoPW2hmxQV7xTpLvWBeDFWO1pWENIujxiYpJw6mJRi9LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757744245; c=relaxed/simple;
	bh=wuvNk7YIn1aWYwCx2L8K6dZ+hjBFxAZx4dZTxeBRP2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcQmOpi/HlXr1c8w0uid0izvElugCqEwDPpbBYCCYevo8nStciyQYaEiWzVRhbpevtQNQze8ZYQpV0+S2Ce8VHrW/MhihftEIQ8ZWZsHTEzRz89yOttPXhTj9M1l90ERccoa7mC/P2Wweawbx7zzgziS8of/L/1FZ/XAcIiiraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-244582738b5so22144285ad.3
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 23:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757744243; x=1758349043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whstITD7FD7VzEh3PkMP2EuVC8gwBGZYuJNdrrp6Ya4=;
        b=hL8S5VOjafK7NXEsliSXszYuclgGbfw6zcg4Sypi5vLvlLYiZs/lpTJGV2VEpUnf1S
         MHTX66Emkd1FnugbpgjWrX2guw8E9SYACNanEO92yAjIbTmtMZBFBakWSzwQeFCAHRou
         JqAen7VgHdtzAVMgQCK3gqbOTSBgISJClAC7p4n4wiGeR9DGzlmKCGX7sWgShwwDZ0bS
         x5hBqMjhOXlnrxAyS8wCm8+mAGJ/0t3qaJvZ8bHEhKn8k6GCtdUnj3ynhI1c2oWfpb5n
         BsyE2lZYw1gAhJitURitfrM8R4C8zSFvOxfIEQ1YY6SgyI1NZ+TIg6KEQt/tRoVWW0qa
         duuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0wGD3ov6Q14SwcHXUrtvBfweeIH7l5cVDBD6jNLq/hr77h96lET3kBBuPmr+EsuhJmbsUCpl13GA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7rNf7yaVaYaZ5BDdA8qHH0cLHTUemxbr/kAd7LjpHSKJUnIWJ
	MmVO74sNcHLRVVhjlt8+6wedO5ioFodwk2U0mJEHeyxsXAeW1feyG696
X-Gm-Gg: ASbGncshu+oSub2oN/ydZ72DALQLlSVht9isDVI0FTEnsoAPTXHNw/J4YSaz9zRjeJi
	M0audNxCo40zbGyR/zYTV+0LFPvQHXioK4R6vT7LQvFkXnE0RNd6cFQI4wqRgzM/OEewVc/RuBx
	Zzsz1nDVEGE5o2VqWSpKCRFcdajILfD6pckDOyGvHrQI/boWoMnDCk/CC/mh+6jB/U7K3AZOp8K
	ErwmoIR7zgXS+LtdhmUxnjHKOyGQmNr1h6tMmo2bzt+HHmXY7qe32aL+v7hMU6YtSrMlqQC4kHT
	23JKr/Dx0hwYgW/65hbGYQzVAfOU+X81ErLAucqG2GADSo6Ux/qlaWS4iTPnuJI/nSWDLbhbchi
	c5PA2whzNrhuS3L91d3BdGhfhYY2bw1XeviuQ46NLjva54fXc0skExm4pm8PpSmCtjIbB
X-Google-Smtp-Source: AGHT+IErQIvtqKLR1glNnSs4Q72WjCl8l+b6YxbIU5vQjpqoMbOaYdi0OfoKQe75DvLs87WIodEV9A==
X-Received: by 2002:a17:903:3c2c:b0:256:2b13:5f11 with SMTP id d9443c01a7336-25d26d4c335mr61440085ad.40.1757744243128;
        Fri, 12 Sep 2025 23:17:23 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-25c36cc6cc5sm67443515ad.27.2025.09.12.23.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 23:17:22 -0700 (PDT)
Date: Sat, 13 Sep 2025 15:17:20 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Matthew Wood <thepacketgeek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mario Limonciello <superm1@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250913061720.GA1992308@rocinante>
References: <20250821232239.599523-1-thepacketgeek@gmail.com>
 <20250821232239.599523-2-thepacketgeek@gmail.com>
 <aK9e_Un3fWMWDIzD@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK9e_Un3fWMWDIzD@kbusch-mbp>

Hello,

> Can we get a ruling on this one? It's pretty straight forward
> implementation exposing a useful attribute.

Who needs this?  Why is this useful?  Why hasn't there been a need for
exposing serial number in past decades, and suddenly we need it so
desperately?

We probably wouldn't want to add this if there is only a single user that
needs this, especially give that userspace tools like lspci already expose
this when someone needs it.

Also, we were reluctant to expose some types of information, like serial
numbers and such, via the VPD recently, so why exposing any serial numbers
via sysfs would be any different?

Thank you,

	Krzysztof

