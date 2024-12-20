Return-Path: <linux-pci+bounces-18907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4B69F9220
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 13:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65601670C0
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989392046B5;
	Fri, 20 Dec 2024 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5M/fEY2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55D51BCA19
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697354; cv=none; b=Mq+D+W1MZTrcn0MEQDyRmheqTq34jtLjKFqEoxHZuXcJ1TMoBjg811rcg0DROwvnhyu+j4gTQNp4QpFKODOJyh49xYXD0ufLLwS/RCNvTxMsXygdAQrjieeEdHk4T4XFMKLA5oK68ikD/JE+8tEhBcFS2BsPjYXOy4zqZj7mrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697354; c=relaxed/simple;
	bh=W5+q0XJLUlFS3QQe/fBa2GtWW85O0vw7b64MtS1z25w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUoTmalBH1s1eUiYflrM/Kk3w2Z+jVinPsDhQc281rssRfltl/YEPbT+5r+XJOF+RLiKMvZYYpibpaRN77U26CJ2CvQ2YdOsokNSCxlCtxpuu8jbypR6QnmWnYpycFhwdmOmxfs4SJhnPpcssCYSbpwuc8vCFVc+EXplpMY+BVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e5M/fEY2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7292a83264eso1624236b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 04:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734697352; x=1735302152; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oWMz4Or7oMQmuw8gXtGP6co0bEIH20jpOM6bqYupeRQ=;
        b=e5M/fEY2nmV3K8m28g9kD/barz6O28sNU/JUmpJ0KdHia7pxZ/FDmg4nES5JLF1tDu
         c5GtuGcIMbzRHvzv4K3aTykj5lt+YtjZAdfZVLTTltyZFzyL2P6ns8Jxgq5Cv1OM2ylw
         3EX8QXTolOjGzZsB3v8uAfIROIMLLLgEzYP7lTDS7KvVhe3wPp/ldbfPMkTxvlcbO2nh
         WtZB9zJuVw8ObrcWhRLLfkk8Ecz3v1aBGj74ZULNCA2VNU3QOrshoRKdhbVXIL8GJzzu
         5e0luidiXbtQCiJv4eK6DUaJdMQppRJELX0jElrZnqhsvVz4pliY9S0gICQEk35WBIZK
         iu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697352; x=1735302152;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWMz4Or7oMQmuw8gXtGP6co0bEIH20jpOM6bqYupeRQ=;
        b=WzFDQVcsW5bzWIiaqQQx79aIClccTjzSNa+kLoakBwjIiB0rzsmD80Pbt8qEnD0Cmo
         iiSWXRNcnG5JPPCb0sgnHXthZWGi7t5s5YbQs/a+Zeyi8hwQdbG5r9+N1+dL0mnDYd0K
         jSXYJ4uiNISEC+M3i9gtx7Dy2uLZ4pl+kPT86FVqD+1U9ONKRWlWIpexc6dANg7GtZik
         9w6xhAdWxubQ27MN0KpBZfyKqNvYMYDOfyqZiaGQ14+y2yXLvLQISfvID/4H2BTHAS2a
         RwSlQ/30O45utTTX+Ewys9R5suX5hxNAuor++gqr9ggFV00w7mj7xiv3q7y8MiJ7Y171
         F3iw==
X-Forwarded-Encrypted: i=1; AJvYcCUnsLSxT6Fo8poRlkODk7re1Qyc0hvo1TWG2kJxI99yxt3oYPphKSCs7pSNbdcBHLZP+AUT7ixJuk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwgxl/zVHguS8UfVpZSCXlRIDwTsyPxcQbh3sbOWrTmec3Q6zM
	REXKLesIcEQaBE4ghVKEalhhHFbBLduLwNLjL9ovtn4cI3da8HSkZaVl1nWdNA==
X-Gm-Gg: ASbGnct7BGZ3PCWMQkeqDpvYllRZa5rimOANJYaPC2Up2r0RYu5b0cUhqyhCG7E6qMG
	BRcNzvc+Nk/kGh33s0QMY6eOYdGZt83ARbTdb+oTA9nIgd9cbeC6kNx3udgmsLhWDQHrfnfJ1Bj
	Mtn9fA8M3P4+lsWl6ibJL/OJH+ehkoingzvtPHGVK6mArSkMBdwg/NZkPCnxbOQuaXGEDG+jWaf
	uogZAdgEIceML3srNnmYER07nd3xnaAwtJfSB/WWyUWhame+UNMd1wKnoOobumKrT/CPw==
X-Google-Smtp-Source: AGHT+IFBE2ysCt3TYqJyyCcgYPYBsX3e7fiMItcbT+QolwPmsg4IHUeRQxoA27xY/70Fm+2n4WAWrg==
X-Received: by 2002:a05:6a20:728f:b0:1e1:aef4:9cdd with SMTP id adf61e73a8af0-1e5e0450013mr5074508637.1.1734697352265;
        Fri, 20 Dec 2024 04:22:32 -0800 (PST)
Received: from thinkpad ([117.213.102.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dba99sm2948660b3a.92.2024.12.20.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 04:22:31 -0800 (PST)
Date: Fri, 20 Dec 2024 17:52:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v7 00/18] NVMe PCI endpoint target driver
Message-ID: <20241220122225.lw6mpv7gx77igzgl@thinkpad>
References: <20241220095108.601914-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220095108.601914-1-dlemoal@kernel.org>

On Fri, Dec 20, 2024 at 06:50:50PM +0900, Damien Le Moal wrote:
> This patch series implements an NVMe target driver for the PCI transport
> using the PCI endpoint framework.
> 
> The first 5 patches of this series move and cleanup some nvme code that
> will be reused in following patches.
> 
> Patch 6 introduces the PCI transport type to allow setting up ports for
> the new PCI target controller driver. Patch 7 to 10 are improvements of
> the target core code to allow creating the PCI controller and processing
> its nvme commands without the need to rely on fabrics commands like the
> connect command to create the admin and I/O queues.
> 
> Patch 11 relaxes the SGL check in nvmet_req_init() to allow for PCI
> admin commands (which must use PRPs).
> 
> Patches 12 to 16 improve the set/get feature support of the target code
> to get closer to achieving NVMe specification compliance. These patches
> though do not implement support for some mandatory features.
> 
> Patch 17 is the main patch which introduces the NVMe PCI endpoint target
> driver. This patch commit message provides and overview of the driver
> design and operation.
> 
> Finally, patch 18 documents the NVMe PCI endpoint target driver and
> provides a user guide explaning how to setup an NVMe PCI endpoint
> device.
> 
> The patches are base on Linus 6.13-rc3 tree.
> 
> This driver has been extensively tested using a Radxa Rock5B board
> (RK3588 Arm SoC). Some tests have also been done using a Pine Rockpro64
> board. However, this board does not support DMA channels for the PCI
> endpoint controller, leading to very poor performance.
> 
> Using the Radxa Rock5b board and setting up a 4 queue-pairs controller
> with a null-blk block device loop target, performance was measured using
> fio as follows:
> 
>  +----------------------------------+------------------------+
>  | Workload                         | IOPS (BW)              |
>  +----------------------------------+------------------------+
>  | Rand read, 4KB, QD=1, 1 job      | 14.3k IOPS             |
>  | Rand read, 4KB, QD=32, 1 job     | 80.8k IOPS             |
>  | Rand read, 4KB, QD=32, 4 jobs    | 131k IOPS              |
>  | Rand read, 128KB, QD=32, 1 job   | 16.7k IOPS (2.18 GB/s) |
>  | Rand read, 128KB, QD=32, 4 jobs  | 17.4k IOPS (2.27 GB/s) |
>  | Rand read, 512KB, QD=32, 1 job   | 5380 IOPS (2.82 GB/s)  |
>  | Rand read, 512KB, QD=32, 4 jobs  | 5206 IOPS (2.27 GB/s)  |
>  | Rand write, 128KB, QD=32, 1 job  | 9617 IOPS (1.26 GB/s)  |
>  | Rand write, 128KB, QD=32, 4 jobs | 8405 IOPS (1.10 GB/s)  |
>  +----------------------------------+------------------------+
> 
> These results use the default MDTS of the NVMe enpoint driver of 512 KB.
> 
> This driver is not intended for production use but rather to be a
> playground for learning NVMe and exploring/testing new NVMe features
> while providing reasonably good performance.
> 

Series looks good from PCI endpoint perspective and I've given my R-b tags. I
hope this gets merged through the nvme tree.

Thanks a lot for the work, Damien and Rick!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

