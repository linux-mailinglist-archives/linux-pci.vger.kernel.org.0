Return-Path: <linux-pci+bounces-14598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B50E99FC93
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 01:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB21283A4B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 23:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D23A1B0F18;
	Tue, 15 Oct 2024 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slwFGdTZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC34C21E3AC;
	Tue, 15 Oct 2024 23:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729035950; cv=none; b=Dy7hY2jCNtHEI+G7d4PpQi28WaCjoWCSQgHvOc9+45piDVHOzmuXcRC6WzX/ohagXV+IBSQ/zSIv2JHgreAGsmKSzaq4mPRoZXztw0SViuH6B64l+FgEMv75a7U1ABN5BxlVeG8ItPqGbh/PKlJKoyYBKL2YJeY94cSqmJDZreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729035950; c=relaxed/simple;
	bh=VUTSyIIZybScBanSxK1Lfw1t1mpTWNeI88T5eH5LUXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1TibhIv1f5bSb/MkQOv3fAxRy5JqcWJ5rMhjoFn2A61bqYc0kLpBBpp/QhFqEJWuIlANSUnw/3Ei7/Xps4lzxlAdPq7OaJtdFKUdxkqQ4aZr2ghoBGAecYZS60sa6oitogShRXqBqu2E2EbVLlI6TEaXwxKqcBjH5HAFKba2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slwFGdTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E413C4CEC6;
	Tue, 15 Oct 2024 23:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729035950;
	bh=VUTSyIIZybScBanSxK1Lfw1t1mpTWNeI88T5eH5LUXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=slwFGdTZwTTeFdq8IE/pPV16k+t4vKZdgjlMa885BQa5NIjZLvuV92DFqzukexOG7
	 hp7o/TFPmmlLzME/Yq2RYV4FGH7q69Q/HwXRQu3nMCPaNpKOI95lu1QEP/GJmSJ1FT
	 Gd0wvHMqKSOsokM/AszcfFz9uOE5ZeRj2PBQN02n+vuzYFc5AidDzzDi0P8+c1NQpp
	 wmzXgYrwhL0nhsEi1PjwZxhiH55yDV0s/zcnqwxQr82Us7OtOJcq7MfgNyaFjhAMhM
	 oOOp+/GCqfPtFxue1YdsJmj3oHNWlJjVLLNR6FLzY2RbVsIyFJ6IkCZQ876iNV331o
	 dhsBM/ys8DymA==
Date: Tue, 15 Oct 2024 16:45:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: "Panicker, Manoj" <Manoj.Panicker2@amd.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Jonathan.Cameron@Huawei.com"
 <Jonathan.Cameron@Huawei.com>, "helgaas@kernel.org" <helgaas@kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "gospo@broadcom.com" <gospo@broadcom.com>,
 "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
 "ajit.khaparde@broadcom.com" <ajit.khaparde@broadcom.com>,
 "somnath.kotur@broadcom.com" <somnath.kotur@broadcom.com>,
 "andrew.gospodarek@broadcom.com" <andrew.gospodarek@broadcom.com>,
 "VanTassell, Eric" <Eric.VanTassell@amd.com>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "horms@kernel.org" <horms@kernel.org>,
 "bagasdotme@gmail.com" <bagasdotme@gmail.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "lukas@wunner.de" <lukas@wunner.de>,
 "paul.e.luse@intel.com" <paul.e.luse@intel.com>, "jing2.liu@intel.com"
 <jing2.liu@intel.com>
Subject: Re: [PATCH V7 4/5] bnxt_en: Add TPH support in BNXT driver
Message-ID: <20241015164548.6c7ece5f@kernel.org>
In-Reply-To: <341139a9-a2d0-465e-bdd3-bdd009b78589@amd.com>
References: <20241002165954.128085-1-wei.huang2@amd.com>
	<20241002165954.128085-5-wei.huang2@amd.com>
	<20241008063959.0b073aab@kernel.org>
	<MN0PR12MB6174E0F2572E7BFC65EA464BAF792@MN0PR12MB6174.namprd12.prod.outlook.com>
	<341139a9-a2d0-465e-bdd3-bdd009b78589@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 14:50:39 -0500 Wei Huang wrote:
> Any suggestions on how to proceed? I can send out a V8 patchset if Jakub
> is OK with Manoj's solution? Or only a new patch #4 is needed since the
> rest are intact.

1) y'all need to stop top posting
2) Manoj's reply is AMD internal and I'm not an AMD employee
3) precedent in drivers means relatively little, existing code 
   can be buggy

