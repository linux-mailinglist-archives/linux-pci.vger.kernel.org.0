Return-Path: <linux-pci+bounces-12228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8F495FD7A
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 00:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE431C20D86
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2024 22:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD319CD0B;
	Mon, 26 Aug 2024 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twrNSgRR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA319AA75;
	Mon, 26 Aug 2024 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712555; cv=none; b=amGxA8KQz6u56p1hhuVi3Lf4FFKCdWgIo8XMqiHs6OEt14VNId+rCI74etlt08LD5c/qGqEw3Vrm6P9HwDShnbyCfouv+f4Q3nRn0BjKdiT0xYyuAJV0FX++u4oyMZ4pKm5Rqq5Ts6zaH0FDOP6tLuceL+Z4kAokiEzhK398KcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712555; c=relaxed/simple;
	bh=grnn+0X0Pv3NMfzAZs3RQzlylVqbv+q8SRYJqfAZiq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qa+JUpxLw0kl3fBmVNrVM+Ky3kuQ0CYDW4TdCrjVKLQgSFqPauKp6Vfh9NjKBF19y2JR/4nhB/8RDd2fNcymWCz+dAx10O5lLa1T/nloRnp4sMM6DfxthI3UqhsyPCGcDRK4MQGVnrZ5yksboAWLLD5wvpN7CzsnXxJfmOTJ7CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twrNSgRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBA3C8B7A4;
	Mon, 26 Aug 2024 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724712554;
	bh=grnn+0X0Pv3NMfzAZs3RQzlylVqbv+q8SRYJqfAZiq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=twrNSgRRSQB0VBfhAlkkOthBteBjUdBTZO1/6b5u3dWnNEtqub1ex/Tf7WnyRXjnN
	 kZTfGhQn4fWAQq/dGM0irikvWrrSLx7yloXFbm0pcAS8AGeOfQse4Z/4W4Nxb+hhvJ
	 b0Tar1VRHH/Hyg/Ts61+r4n/u+WsSZiqO8Xv72lLYJiUd7Yy7xxB7WgfcuIhPPmRqi
	 LJrjgu9YAd6es2vYadWXZGtgx+5NDYkw0Rn+GEDJlvYLSL35LUhaVnsQuPW/MDkv1s
	 71KxiTy15zh7RY+lv3x7EwJmlAi9aCx1Nln7ch7gYWmiMri0gMggq3GLT30WDpI1TJ
	 yDJfdn48+7o7Q==
Date: Mon, 26 Aug 2024 15:49:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, Jonathan.Cameron@huawei.com, helgaas@kernel.org,
 corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, alex.williamson@redhat.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
 vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
 bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
 jing2.liu@intel.com
Subject: Re: [PATCH V4 11/12] bnxt_en: Add TPH support in BNXT driver
Message-ID: <20240826154912.6a85e654@kernel.org>
In-Reply-To: <ZszsBNC8HhCfFnhL@C02YVCJELVCG>
References: <20240822204120.3634-1-wei.huang2@amd.com>
	<20240822204120.3634-12-wei.huang2@amd.com>
	<20240826132213.4c8039c0@kernel.org>
	<ZszsBNC8HhCfFnhL@C02YVCJELVCG>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Aug 2024 16:56:36 -0400 Andy Gospodarek wrote:
> We plan to replace these calls with calls to stop and start only that
> ring via netdev_rx_queue_restart as soon as these calls all land in
> the same tree.  Since this set is [presumably] coming through
> linux-pci we didn't think we could do that yet.
> 
> Thoughts?

The merge window is in 3 weeks or so, so this can wait.
I'm worried we'll find out later that the current queue reset
implementation in bnxt turns out to be insufficient. And we'll
be stuck with yet another close/open in this driver.

While we talk about affinity settings in bnxt -- it'd be great
if it maintained the mapping and XPS settings across reconfiguration 
(like queue count changes or attaching XDP).

