Return-Path: <linux-pci+bounces-11758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937F795453B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 11:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C601A1C20D2E
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA62B13DDD1;
	Fri, 16 Aug 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOFg711Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9891713DBBF;
	Fri, 16 Aug 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799568; cv=none; b=VMUCMxRAc+lN/eoGx7I2k8Iq/XjWnG4GECWBgIaTdEodA2hLNoYi+jfuSKCG4mZ9wIJXQb8ZZxS4NJNsUyLR9ZZH7vFQVbmJtDaiqfcXVCB9cKVVujynK4c6sf9INfZ6LeNMpXqzCwIdA0StA2YV+9geFJtfdK5bnwNJmOEFKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799568; c=relaxed/simple;
	bh=pE5KrhJEFY9/bCRrBwsiQIZ1HfJZEZWnZP+tor9EZ5I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WaBvWRuOaoKyFMdiKjfFyAuGwBCPDD7LrbUxYFilDdp3/IXt0Femg6UrZvslmEOcYJCAzp1kgp0xpQREHt9SD7dGUZOF3Aak/Cju5YDByCb45zHmSmAIks7PfGvAW/Pze011ZswfgQlIU8c+h4aZbwHLsPBOTK5L/ND1//8p9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOFg711Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7A3C4AF09;
	Fri, 16 Aug 2024 09:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723799568;
	bh=pE5KrhJEFY9/bCRrBwsiQIZ1HfJZEZWnZP+tor9EZ5I=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JOFg711YWxgNq6qOJ1zg3vPBTyfziyukZMWg8y/NjOaW/eIEMsg5wZIQsKdlCjVs+
	 XiV5/zKix6JGrbnOzNPFvsvtK8yE4CfxTzSEypXVe4Ton5wwvcdk45tzvMkATA0CRd
	 rMBCMjgPOzrUFleWBNSzTtaXubAWz/6CWr5cmg2wT7DXjzX/kOe8RXJ2+Pctcl8cuA
	 /bPvzhiMTz0qivwIXKOEQt8ZKrfIbf9w6DkGwGTndz7izbsVs9iNFjdzPP97GA0f5q
	 DP7OXE8jdICIGlO1DSIRqfOvtHwv8MBzIT5jWtj9bG7Xge0RaJEfX+/8oaURe4EXY1
	 rqjGRj9NV4k6g==
From: Kalle Valo <kvalo@kernel.org>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,  Herbert Xu
 <herbert@gondor.apana.org.au>,  "David S. Miller" <davem@davemloft.net>,
  Andy Shevchenko <andriy.shevchenko@linux.intel.com>,  Jie Wang
 <jie.wang@intel.com>,  Shashank Gupta <shashank.gupta@intel.com>,  Adam
 Guerin <adam.guerin@intel.com>,  Tero Kristo
 <tero.kristo@linux.intel.com>,  Boris Brezillon <bbrezillon@kernel.org>,
  Arnaud Ebalard <arno@natisbad.org>,  Srujana Challa
 <schalla@marvell.com>,  Nithin Dabilpuram <ndabilpuram@marvell.com>,
  Bharat Bhushan <bbhushan2@marvell.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Miri Korenblit
 <miriam.rachel.korenblit@intel.com>,  Johannes Berg
 <johannes.berg@intel.com>,  Gregory Greenman <gregory.greenman@intel.com>,
  Emmanuel Grumbach <emmanuel.grumbach@intel.com>,  Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>,  Breno Leitao <leitao@debian.org>,
  Jonathan Corbet <corbet@lwn.net>,  Bjorn Helgaas <bhelgaas@google.com>,
  Mark Brown <broonie@kernel.org>,  David Lechner <dlechner@baylibre.com>,
  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  qat-linux@intel.com,
  linux-crypto@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-wireless@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 06/10] wifi: iwlwifi: replace deprecated PCI functions
References: <20240816082304.14115-1-pstanner@redhat.com>
	<20240816082304.14115-7-pstanner@redhat.com>
Date: Fri, 16 Aug 2024 12:12:39 +0300
In-Reply-To: <20240816082304.14115-7-pstanner@redhat.com> (Philipp Stanner's
	message of "Fri, 16 Aug 2024 10:22:58 +0200")
Message-ID: <875xs0ygoo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Philipp Stanner <pstanner@redhat.com> writes:

> pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
>
> Replace these functions with their successors, pcim_iomap() and
> pcim_request_all_regions().
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

No response from Intel but looks good from my point of view:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

