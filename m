Return-Path: <linux-pci+bounces-870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F48810FB9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 12:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A20B1F21163
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 11:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E1523760;
	Wed, 13 Dec 2023 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="T+y0fRmh"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3824CEA
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 03:22:48 -0800 (PST)
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id 28A1428C217; Wed, 13 Dec 2023 12:22:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1702466565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tfus27BRDzGyGrj+xHZsKtOF1/ghb/M02cNu+OK88Es=;
	b=T+y0fRmh9LaEuxWP8JMldBthaBxw+Yn15SRz8jMmMgO5I+i9vDujqHe3xDnBAOXWaZKfWQ
	kDYv5Cxe+QFDBWZQb2h/7+Qt6dEY9o2tBzRkf4wseka3VO2I00swdLrRz2CbDP3AqakOU1
	SGIselu2MaEHT7U3rjR1pY3yWu8EqtY=
Date: Wed, 13 Dec 2023 12:22:45 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: Nikita Proshkin <n.proshkin@yadro.com>
Cc: linux-pci@vger.kernel.org, linux@yadro.com,
	Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH 13/15] pciutils-pcilmr: Add option to save margining
 results in csv form
Message-ID: <mj+md-20231213.112217.6063.nikam@ucw.cz>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
 <20231208091734.12225-14-n.proshkin@yadro.com>
 <mj+md-20231208.174204.32403.nikam@ucw.cz>
 <20231213135256.145556b6.n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213135256.145556b6.n.proshkin@yadro.com>

Hi1

> I think that die() from common.c is not suitable here, as the utility at that
> moment in the code still can and must free up resources malloc'ed in the main
> function.

I don't understand why this is needed -- once the process exits, all memory
allocated by it is freed by the kernel.

					Martin

