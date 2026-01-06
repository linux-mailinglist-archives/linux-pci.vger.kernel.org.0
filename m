Return-Path: <linux-pci+bounces-44070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03814CF6229
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 01:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 137EE3047656
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 00:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C3D203710;
	Tue,  6 Jan 2026 00:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UUL7+GZ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1438A1E5201
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661082; cv=none; b=CFQT61pBaK1rn6g6pNYlc+e1mB4hpLZpG55v5WrVmrPr7qvvFRGSZ+oKpMPjCnFpWEKpJAyFsc2Zgi2blQLJsfcbMGo/Ukkubc5On9kaCfw7dU5uesFA1Pl9i6gvrYdheORDIpou+gqdmxVbmuOVQGxW4/WfL/UOQRBYROlWz3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661082; c=relaxed/simple;
	bh=KWvFDvXHT8S5dvDF1yI8ZG/GMpS/ULrliFX9M8TUh2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZpCMuzB6K3KePHYIKGqZEGSDYVcpehE4AA77EW+28y9+4RPRclKhnmWNWuysVqQbwl8ZA+vNi+7Yt9B7v1dy+BLUY/vPV2Ppoy1PCiyjajmVF3/dHyRHvnAHmrNIrsnEHzpAhWJxTFtooC5/RP00kH8RpysvnD3CXKn+Ll31BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UUL7+GZ3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b220ddc189so60874785a.0
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 16:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767661080; x=1768265880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KWvFDvXHT8S5dvDF1yI8ZG/GMpS/ULrliFX9M8TUh2Y=;
        b=UUL7+GZ3a2PmrXbs0RK+LBv4xwA/xKvTWh77jr057j3BFwrpeqPWoL0Cz50sF0Kll2
         0MrO9BnnnIjJh1NK0+GoDzXJL/rrGji43Q9HMF8e06UtT8qQkGA1tW3vA1bm4Fgupd0q
         bNW9Lb/6GOiiTMt+66QLpNN7wghp4cBP4Z7UApZxqVlqLrrRMdW+bqjulHm9WqG3gbpw
         3EdpgPPeQy3so3TPap7EIoQspsL868iZGtbBaXjE5fpp92DJECwV9dOi3TGjZ10KIRr/
         6Z/lnkJM0HI3njqeVnJSLLfoJbZQZxe0R43IwUWmflG9RB319lWnTrGF81kiIknBJSfl
         /3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661080; x=1768265880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWvFDvXHT8S5dvDF1yI8ZG/GMpS/ULrliFX9M8TUh2Y=;
        b=ZsIGblGy54Nf4XCCbqRXd8Z+VNHAbCwIoRNltHwwrO35HwXvx5TDhXsi9P4DOExAEE
         3/aP7u7UUbtWIRvCifGXszWivkEVkpBwQ0qdFkkWHExe6Z/srzKXrjwekg0/j0BXgBgC
         hk0z2FIljT6ajk50VFLoMWD2DsJ0FLxsbVf+omD0XMrP14haMfPGoQmTtC6yQ7Sh7vW8
         KDGwxDyw1kvHocD0gH6yZetGjcxoMJ5C5EcMZnYExV3B+qsBD62Yn13HEYCGo8EphBOr
         D8rErNPoGjuXnvprr/cE4q35gQ+GgtRKWjpMPwFkp3CPuc0uyixHbBh/bPTRRlLY4aXY
         /IpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3jV9E0Ul40RujKiUsqDaf8oi4a05NjjwxLYyRcIwDS/MoL/5UGyqpzbSkoXDFpjWZb24wkTan1Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xWGEg3ulgqBpYltSdP9haenh00GPmjh0NgmpQnAJy6CiIwb3
	sbFreq/oCNZm0bNpTtotBl5EM9isvfiKkdnsdLiwdq45y5Vv/XsDR9+HbxKkcYy8YZg=
X-Gm-Gg: AY/fxX6RupBudfqvEkfdbt3Ukntv4hmlANVMpCXsEnTYE80gamCD/dHrpzvYuOSTfRz
	PPUXJbb00SZErw5qfuslrjt1iK8gwkQI6krRVNoiQiGQNV3xDQ05jpjpLkRvzMh19lr3Aq1SPIn
	Xmddqwfs4rg9UzrfRgF6vMg0/u+yhknI0BjvKlqoVFMG2g3iSxuC8TqRIvZzojYsJG2CwEaCglb
	iLsc44zMoBNRiZR5iYyHi1TzBC2+2XRJTi0ZVSEb0NdR7iSq036oZ1QnS7AAVQfwzJvBifkrqT2
	bcmB5Lh4phNLNGnz1w10aFiTmV3Zd5d2l4U8pm+MpEonPt6uS9LTcPHn8pmSUF/n1bFkvPnLYnv
	6Hj95wPAE7TCYQrtUJVTZkBiohXF/hdu26O0yoczAFq3O26NgZB4W4YmeP+p4SaeUbeIpKzc+Yf
	5j6T4+kFjNI0qOzIgZfrrGRlEvizfMvSLaYr5LuZHtYwMgnwysRnZqdgIFjmO6K+2yY3s=
X-Google-Smtp-Source: AGHT+IGa0r5JunugmxLwRSZ3te7/5csaOdNw4asu9kfOiZSkSQ9900m9rT02+OnpqPMVecqSE44X0A==
X-Received: by 2002:a05:620a:469e:b0:893:2ba8:eec8 with SMTP id af79cd13be357-8c37ec0439fmr206640185a.79.1767661079931;
        Mon, 05 Jan 2026 16:57:59 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6b5bsm65910185a.8.2026.01.05.16.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:57:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vcvOY-00000001EWh-2Hbg;
	Mon, 05 Jan 2026 20:57:58 -0400
Date: Mon, 5 Jan 2026 20:57:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [RFC 2/2] Set steering-tag directly for PCIe P2P memory access
Message-ID: <20260106005758.GM125261@ziepe.ca>
References: <20251204081117.1987227-1-zhipingz@meta.com>
 <20251227192303.3866551-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227192303.3866551-1-zhipingz@meta.com>

On Sat, Dec 27, 2025 at 11:22:54AM -0800, Zhiping Zhang wrote:
> For p2p or dmabuf use cases, we pass in an ID or fd similar to CPU_ID when
> allocating a dmah, and make a callback to the dmabuf exporter to get the
> TPH value associated with the fd. That involves adding a new dmabuf operation
> for the callback to get the TPH/tag value associated.

Ah, hum, that approach seems problematic since the dmah could be used
with something that is not the exporting devices MMIO and this would
allow userspace to subsitute in a wrong TPH which I think we should
consider a security problem.

I think you need to have the reg_mr_dmabuf itself enforce a TPH if the
exporting DMABUF requests it that way we know the TPH and the MMIO
addresses are properly linked together.

Jason

