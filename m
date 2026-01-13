Return-Path: <linux-pci+bounces-44648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ED6D1A6A7
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E291230169B1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB2C34D914;
	Tue, 13 Jan 2026 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IUN+F7Os"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD8234D4F0
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322967; cv=none; b=ZeMOukK5axe5etOtMrug1c1B+Vl7PbwbsHbPYEU4hiJ1/tDYCBCJZpjiTATi4RwImEQqoMqMfeJIY3VYF25EOyvWIjCDKvXIMRFJxX+28T/Y3/GsJ8RNLu394IB9wqyJaGYg7lhfkLHTMlMq/RmWizJEgQw9wbPtnZzOU9vUFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322967; c=relaxed/simple;
	bh=FcKwhFtwMjJDEN2YQ222Ot6kSiGOtJGNAi5RAuQWTkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/lA2GkhUPLAPLuUOePYYx9rZHRDyWmvYIhmR7B0iN2RFcbhVjDeaVkfAyGsL1fDR0U4m2DRa5m4pnUSSc8vL+pUMHw6VW2BhHY3MO6fSuuvWxuPIiUnN2MNqEJ7fd5EcE6K6MCwASEI7YYuuXJscGh8dLMla34UJg/72Z4hh9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IUN+F7Os; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4f1b4bb40aaso42070091cf.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768322964; x=1768927764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FcKwhFtwMjJDEN2YQ222Ot6kSiGOtJGNAi5RAuQWTkY=;
        b=IUN+F7Os2CbsEpMXD+uy4zfUryF0h24o1jyx/IiYJq7BeVoHZ6z1GLN7ui8LGfBeDP
         DA6tBmkTPIySiWnRFO2xpwJfRu9SLXxaW5kpd8t9UaDDsOIyaFmhxxvdDzVLw7HDPgVZ
         tMZlJgPmwHU2p01l/jcmvEXdj1SWT2nHiRpYbfEBCcreb/F5llf+NsHfCACTdfcMNR8l
         DlZRQw8wRcmCaT2Nvcdpr1DkRQSeSiDyg/bGgMd6WUEpQRAUsjvSw0omNVCqKuNWw+pN
         il0/6wjhstUZFg/vaSnhZQGAGHC5NTUavNRSWwIyuKwrr+1bpAAkJdGo4G27m5McLDER
         h86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768322964; x=1768927764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcKwhFtwMjJDEN2YQ222Ot6kSiGOtJGNAi5RAuQWTkY=;
        b=Dp/qJGqA17wifmKbyHvIpYL+23V7l+pKyLvD50+9mtI+3z9XdNwihfWLhMlphLssx7
         KdCrGPwh5MBqzHrnswjlTLG5OPCmYGKkKizJW3eGYrf0/M+M0asuXkKZ/AEaF6ju4pEH
         vnqlfQ7rvU8nY+lHY91r2Zk+mIEpu1xkK7SyLd8+m2D2v82Pjw5tko+dcFOO1xzUdWNS
         x9bq4YP9wD1N9Tw8IKaoi4qhALO8b6lzkOOLMb+1xV7BM037QBQN+JPik1M/6Hicnrx7
         g54NOdOPKWsWgFQmPk50QoUbXNJQMao9DUFiwjjANIDR34pk5cvfQq2kRLiwjnDB4Jpn
         m1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFvGHJS9Byc+67+CKEh0cFDyNj2uPTHdB2SV5+y+3Dlr8UMlXJpCbOiayyHF+LWwtBXYCuKKJqBbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRjmDa79BzkO/k9SZ55THUYCf8yfpN2C/F4HZYadnD2GlvTzf
	L7FTs0wW9F5ms+lpowOT60va2cTM2awIU0zn+NV1clZJZJzESFwHGl5JF9uXSNzfmiY=
X-Gm-Gg: AY/fxX7fFgvuo1JPi/TfFSkr1/W64riqYutGfbS6IATO/STHfulT35XprUTUoKH/fQs
	9ngP1VfQd87PIIhkEG+/Pm99uhgZPNdiuQiKlqk/45WCSCyP2pnES0GK3IEIJjRU5zPz5SPyO8/
	E5L37wQhGmNbueqlYl2hQuaeehjXT7/G264DKg+uRhA265zX3e7zTp3RtyXBhkB/gFkBzvySeKE
	F1G+h+jHvm3w0IJhNGy2IG6w9iA9uCmz8v7jdpARVa9ZY7kQVzy2JS5UuGXjxR/FVtO0BUCTaNt
	vVY1syWQvQmSrkIP2ZHACQ/FTmjVWCdeVlFocP9SK+ymMgsczquCfhotjDZgF6wxpUgr45te3n1
	LuMqVRlxGsa2NqZ9EHGbw12zUOQh6ItMdqk3ZT2HXMkjIcvx0YSMDk60qFSRTuBjr0LQJ0ZWC7G
	+A2w02j72hEeXV3VVHht1PSxV/0726j7XW01G54F+ropcxaU4bVkyrugL2TXo3KcEpCXs=
X-Google-Smtp-Source: AGHT+IFiSxb4uxmRYe6XxApgypPCZjK3lS4QULTVbEwLXNQHGmzceL2GIP7E4FtNXvFCswjqEyy+cQ==
X-Received: by 2002:ac8:5e08:0:b0:4ff:a9d4:8773 with SMTP id d75a77b69052e-4ffb4afd0e0mr293395281cf.82.1768322964364;
        Tue, 13 Jan 2026 08:49:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077253218sm159988626d6.43.2026.01.13.08.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 08:49:23 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vfha7-00000003vHg-0bmX;
	Tue, 13 Jan 2026 12:49:23 -0400
Date: Tue, 13 Jan 2026 12:49:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20260113164923.GQ745888@ziepe.ca>
References: <20260106005758.GM125261@ziepe.ca>
 <20260113074318.941459-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113074318.941459-1-zhipingz@meta.com>

On Mon, Jan 12, 2026 at 11:43:13PM -0800, Zhiping Zhang wrote:
> Got it, thanks for pointing out the security concern! To address this, I
> propose that we still pass the TPH value when allocating the dmah, but we add
> a verification callback in the reg_mr_dmabuf flow to the dmabuf exporter. This
> callback will ensure that the TPH value is correctly linked to the exporting
> device’s MMIO, and only the exporter can authorize the TPH/tag association.

That still sounds messy because we have to protect CPU memory.

I think you should not use dmah possibly and make it so the dmabuf
entirely supplies the TPH value.

Jason

