Return-Path: <linux-pci+bounces-18914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E17979F9892
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 18:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273A7161F14
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102822ACF2;
	Fri, 20 Dec 2024 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sux4smDW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF36C22ACDC
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734715662; cv=none; b=LeoZFuZJMTurfqkVLi9ph5CIqVv+70yPVKv/+Oxolbet7ZS5f/2DNJNzBHRh4z7qNg9IwicR4AqzX+mgDwiRtsF9XP9YoFtMDZTNQUvrQ8OhNExydUdZozm40rnUjQuCCve7SnNeD1tdkrFFPVE+cgQN0jkyUyPP+/I2858/dsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734715662; c=relaxed/simple;
	bh=ftFlFL8Hf6gjCPdcRFrVx2YclVhyvU0X+h6fy2EfzIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UQNi0igPsXwM9qFnnts2dgxnSTwO895Kv9hBT0k9jb188JulY7HsTRvSl4q40QWY22n1qAL1+oKs5nVI9Q3O/tNo42c1MSG0BwHOWRHBBeG+yTvqORK5lai/Pm/d/J3Xx1A+1AkFVpyoDT++dKi8sLJR136v3Q5GGrvStnz2W4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sux4smDW; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862b364538so1264384f8f.1
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734715658; x=1735320458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl2GUGW1SKIB73yuGvAyVPoBfBy5XbBiVj4hV5yN+VI=;
        b=Sux4smDWvhRYVAocCLrB8sH5Gn4iglVnvLOtYXjw2SwmbrW98B6c98IdTir+VF+VQJ
         W10BWI4R3GFC1zT/iJoBlxuzYK0hnggsfABamHJxaKShxH8tLAyw6SYs1kiT5Zpq5DY/
         y8F5G+SxDNISHMSnfr/J8ZC+W2oNrTFwJ0KMsYltX1nRmRejzvK8hykx9rw4E4PSCPjK
         hBR+wlIXLMxbiloh7lXnf5z8TBJg0j3ePqZ9LWqb7cYYzpaMr36BzlgWIDpW6dDQHpe5
         znRcS8BpCe/go3BIeiuQzZZSpEoYEyOJCj8IeINw++6FJJgIOUIPFK+PvAzsigdqsUly
         aZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734715658; x=1735320458;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rl2GUGW1SKIB73yuGvAyVPoBfBy5XbBiVj4hV5yN+VI=;
        b=i7ausJHdetKxelbUySS6LZxbeFfMzr6cFUPklscAbfW+zmlzOrT5Fm6HU5UOh27z7M
         BJSOuLtMEpvzghmubB0VPNfgXxGAxdwqVbPBGzqF+78LMx04oUq388ID0CCyFcbCcN9z
         i5wGe1htSezm61qZiWAP9r81+1wtTX1TTXBjjQzHW8CxkF+zfwW6iyYrHU6q594kTKW1
         uDiIBiH9s789Ol6cqxJpDCtd5dK3j2MGbNcRJgpDSh6HIEDJGoW4mVV0ge4b2EtSv5MN
         ei6m8B3Btk0Z0fm0hAvZNureKg5KuBMLdFbDGKAUem9uV1MSM7FjbjOoAS5sJAYIr+9t
         5oJw==
X-Forwarded-Encrypted: i=1; AJvYcCXlZpSNwzMKyxtW4sFhqmQaFAwEtbbpmARAy+PBzxnMdHikq43TA5mfoV0ZlAgGgUv3/KMGo4Nyp0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww32d9gfpkEX2tCwzNxz6GubUsMooeG/O5c+QskvAQA2OHrnW1
	1V9pFcJQia/W4hdlGNk/zTlVzma94Qm2teXchwld8reJfzXHY0hWdIddmq7PCbs=
X-Gm-Gg: ASbGncuy6A66EJRZDKZ6sFFXVQodcySKFv5WT+voPz/ljubbMGpqyJOHAijAtHT8SAR
	jFKa80IwDjfiRUgNIPJDpKO2BNsN66Os6oQvwlvjfrkby8eDH2NFlKMe3rbzHO9AZg08KUnoBhI
	AGRA/QTpctsTXDdVFxYaYNOxkl3dT1405FrhRl+fw7byqUHs7/8coUwQzKyknKkmmy63PSl135/
	v4Uv14F8Qz0VvyjkQDhZIaz5mdrosHD5F6VgK7ABhAbvU3DnRsQJjGaoXANnrDU/+46h2cSOak=
X-Google-Smtp-Source: AGHT+IHQofl14bIpVpiQqz6qAEwAjKsEmWVjRCOjis6wH9jKfvKMjWLHCbYlsDgmYPDOjR7ci+Y7xw==
X-Received: by 2002:a5d:47c3:0:b0:388:cacf:24b0 with SMTP id ffacd0b85a97d-38a1a1f7253mr6745803f8f.2.1734715658179;
        Fri, 20 Dec 2024 09:27:38 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e357sm4642915f8f.72.2024.12.20.09.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:27:37 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-gpio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, audit@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Zhihao Cheng <chengzhihao1@huawei.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-usb@vger.kernel.org, linux-mm@kvack.org, 
 maple-tree@lists.infradead.org, alsa-devel@alsa-project.org, 
 Sanyog Kale <sanyog.r.kale@intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, dccp@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
 drbd-dev@lists.linbit.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-leds@vger.kernel.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org, tipc-discussion@lists.sourceforge.net, 
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Subject: Re: (subset) [PATCH 00/35] Reorganize kerneldoc parameter names
Message-Id: <173471565665.227782.7244101246430956449.b4-ty@linaro.org>
Date: Fri, 20 Dec 2024 17:27:36 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 30 Sep 2024 13:20:46 +0200, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> The misordered cases were identified using the following
> Coccinelle semantic patch:
> 
> // <smpl>
> @initialize:ocaml@
> @@
> 
> [...]

Applied, thanks!

[31/35] slimbus: messaging: Reorganize kerneldoc parameter names
        commit: 52d3d7f7a77ee9afc6a846b415790e13e1434847

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


