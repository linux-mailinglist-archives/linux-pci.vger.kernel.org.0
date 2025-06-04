Return-Path: <linux-pci+bounces-28957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FE1ACDBEE
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EDC176094
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1339B2236F0;
	Wed,  4 Jun 2025 10:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBjigJuM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C6223DC1;
	Wed,  4 Jun 2025 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749032718; cv=none; b=a910ksE/hxe4IKmRrbuiPF3Y8C8eeVwK46KJCv1WbqKsmuOS5OXZB+6BgE+KVoEi6IjX0fTukP8ldSj2x9Em1jJ4bwjXZR2i36w/89ouzHm0XRLdShT0ORNhsDvr7MsLIdDAtKvpDUXP2VQWTDtfX9wzTTLXHDDNyLVIAgdT6GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749032718; c=relaxed/simple;
	bh=BNG3k2EZnzx3U0v7bx3XO6iS4R70EkPOxvqtIZ8NH5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUVyLjBQQ9OB0iJzbukF7+BPYETVVZ/Bxv5byYLFFwgJfjODqzjR/QI0iWzfPvE0d4/PUlmV7fimyPfYRXtCM5b7/j8t9TWiJ92AEO6q0HNHwCEDgfQpJKHl/c132xQWENCBj8woH7GwVd14uJ3v+00sNZVMlKscUkuC/COOe8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBjigJuM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2f0dc1424aso1058791a12.0;
        Wed, 04 Jun 2025 03:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749032716; x=1749637516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBZorERfZGVAeB4b9MQwohizAQ7RVji7qJz8RExp9pY=;
        b=OBjigJuM+TBFoL14Ls2dFluDiRsB9lpB0stdbpVE3O+KLi43qwAJf6+SkFLqf8wtrh
         z4E8Hrp2utOJPa6ZcPc3szHkwmUchc+rJXlKKIMfh2IxF+l/xXSFulGcXHql4cZ9801d
         T2eJJoP9gW6iP8ADUWbKs6re3YFt3QMI988YxodWoMBM/5WKZ/cCcXXrrVCkvXmSUUn7
         VP/8NC9MAH21irCgftqeFgCa7dkugQcmr8l5TxyzpiHBgB6MCtwrFHikujFDU9WXQAnp
         frav6voCNGHfKf3fLdAq5DLdNDib+IceOfOBegVPZkaWnNWXjzOFf6FtIiSgraVcxN5G
         7xGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032716; x=1749637516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBZorERfZGVAeB4b9MQwohizAQ7RVji7qJz8RExp9pY=;
        b=pm/1KrGB/h9ESD+J88lHyVzUPBxPte3JkkM+RkExvnfauF6gOB/A3fu03BaatkjdwC
         sGvAvQclJ1f/oLnG/cq5GQrnikin8IxlF2LhxVTBWo7yvOtstVZO5uNXzboDgbOfsZN/
         hkeqjoMe2EFtQOs6a/QEOuGPYGur2mJ60ZTjhc94Hqk8Z/C/gcrzbvZgPPFYOyyCZS1B
         1RkClGSfw0qz4d0F592l16urYUDSmR/HsQNt//lSfJhz/HHg5oKkaTH+3qHpjPtVkTRc
         +jndPa8BVwPmJd7FQGE1PcHddYulnlrMtJ51ReTXFGLe0aXsMx3sfwM/Pam6I0R4mJsx
         7JCg==
X-Forwarded-Encrypted: i=1; AJvYcCUWTLexuRBaIreLohn9I0vD3DcnifIAbEl3ni3LpXXGMBFCKbEtMnF2x1cFcOLQKRNZIeDChQNX/pKL@vger.kernel.org, AJvYcCW24ioTtwjPRHwn8tsQUvi9QZWyRUua3gL5nI0xD5vGkZPmdV7j5VOcjA0nkCuds6eSAE/XZIDqFRkapfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9id+wA9qn7Wb9QeAoFoUuhjaotJhoEUYwrhdS5Zx10x8yJNNQ
	WjLrxpdxYH724mhIU7IhGICBQ28K2RdTt0pdlnBFmWuDWaPnuANBPL1z
X-Gm-Gg: ASbGncsVnX5MUGbvBz+IqYRMhiMkcKeoqmYff8Zc8r/yutjES7lPQCAeMg6eFd0WlqC
	on8iQKqjyc0T2pSWDH0wrXrCyJmlHjTjACC7BK+v7ZOvF4r6eLa/N0RjUkyYPCpDmXelIiq3RGo
	zlzj8NOffh9MuxzXkOWRZbQVbmmvl0CIT0utvyLo7O7Fo/wMAP10rED9DlJwUk/ocw5+4nrYOau
	PpU6Uq+oRP0cC02vvLgtNrxNdIbqrhOvUp/TS7KJ0KrspNwZS8CKddC3+sWC1Glu7iZxBkogolw
	n71Ji7kbu6NmKEtCP1X8YyQdRctjFldZJgw+bIOmv0dOGG5g
X-Google-Smtp-Source: AGHT+IEKyQ32HiyWlJskTxRYL8AQnVG4qWWHt6Qqr3ywr5giPCq3wD9L9VKOqjgiM8Sod4EwUE2ZGQ==
X-Received: by 2002:a17:90b:38c4:b0:312:959:dc45 with SMTP id 98e67ed59e1d1-3130cca4fdbmr3399852a91.3.1749032715722;
        Wed, 04 Jun 2025 03:25:15 -0700 (PDT)
Received: from geday ([2804:7f2:800b:7b3::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2c2fa3sm9473906a91.19.2025.06.04.03.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 03:25:15 -0700 (PDT)
Date: Wed, 4 Jun 2025 07:25:09 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <aEAfBc3gsVTmkCyE@geday>
References: <aEAOiO_YIqWH9frQ@geday>
 <317943F7-8658-436D-9E3C-05CB6404F122@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <317943F7-8658-436D-9E3C-05CB6404F122@gmail.com>

On Wed, Jun 04, 2025 at 02:20:20PM +0400, Christian Hewitt wrote:
> I think you have me confused with another Christian (or auto-complete
> scored a new victim). Sadly I have no clue about PCI and not a lot of
> knowledge on RK3399 matters :)
> 
> CH.

Hi Christian,

I did not confuse you. I thought your work with LibreElec partially
involved getting the ol' hand dirty with RK3399 patches. But if it's not
the case, I'll drop you from future Cc: on this subject.

Thanks!
Geraldo Nascimento

