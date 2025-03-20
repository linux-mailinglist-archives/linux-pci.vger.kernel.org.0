Return-Path: <linux-pci+bounces-24208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDF1A6A151
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 09:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513951894FAA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083AC20F070;
	Thu, 20 Mar 2025 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lieTvwRV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6281EF38D
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459248; cv=none; b=ukPtyb2Ha5t+TVhVkExNy6J/CDLRXienfpI9jrLAJoOB+Nqla8t+zNI9d+WFh304sx5/wVHiA1P/nEY3M4IQHahBGs9RDjP4qrS6NmoXfcAop+Z2DFSiw9WUVq2qFYuHoPgZ/Xk9tC3CGdfgg4Sq6CVaTcTzAB7NSxyU3lxL/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459248; c=relaxed/simple;
	bh=TkdH9rwfk1yX/+JzQYX7/jms/zUnZC1NHDawxviZp0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eanLIZGa77cUR6e+OhSKdmhOrDJ46brP8OMV2LXqUXTVvxOSYslfXi7ZQoPfNBgTD7g16JGNNhPhb34Q0k3iC8ngqGvkvH1y/QvtjdeZRSSyz1KvdrpkoyXp/txE/eYVCH3gGttQdGZMstzMCHoQVheLiz/EJ77YVGwlYpKYN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lieTvwRV; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so840741a12.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 01:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459245; x=1743064045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkdH9rwfk1yX/+JzQYX7/jms/zUnZC1NHDawxviZp0g=;
        b=lieTvwRVt7l80Cgh56CJitI3eW9Ap6rio4oCqfzhfm2v/O+KF5uS5gV0X4UTSOrVUP
         aV9Hx+VeqX7K+e2UwTit8dAlPANniZD3tOz8hv++ecTc+KU0fPYjn4PVAUk8go0O76O8
         /AWwnk+s7ApGd7VfBcTZxpTMrr34beVcRhT8BQOi6hB67eZkTmsSAX4APHdQ1MY4BYu2
         KJs5VDpB8QS9rmq30JEgS+600o51sSAqW/7GsHq/7Hl5FkRdk01C/lRudtJkgktkSh4P
         0q+4ivqcYcRc1ZQHn8Nv1YeJx7xP/sP82Xq7hlQnJe93QqujXv+h0E9/mZmMZkUgJJoD
         xMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459245; x=1743064045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkdH9rwfk1yX/+JzQYX7/jms/zUnZC1NHDawxviZp0g=;
        b=N3ZL8PRmdIn7zbmz9b4KG1RWOMW1ATF6zHN0F7f9KAz2mHz73yD8e2tcwLMTyp5DBe
         k5PXpLysS8VMC5sBjQ4lS9g7fdvUCIpKl5jkwWrjx8SQdgAcDlZvZo/VpxDwewlxs4uM
         2GfBx9a4cMLKRW7FRYyAsV/qNATnEXhMoX95IZ3eol28e3bmgs2ri4arvKMIAba8dONQ
         RM1mhcDzWuvwaqXTuUyGi/yBwasVGBjDz4qv75R0UQtsTdRqttPH/VNb1XhxDo53lMaX
         CUYOLYWLSq6gVBedpJzJcMxIYZP2T+c8T1KyZt2GyZ8yAniepcp0FlSzCbwN4ERc1O0g
         hvKw==
X-Forwarded-Encrypted: i=1; AJvYcCX26LSV8Zmcv7r3CYhz65tcX9tk1fFYADojiyAy/UMMRticJlsPnp20h5xCNvYbkTI+TnDnzdLPW2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwUzU4vvI3YcGgdAg4YxtHepANcV1gfjhnzFz/qgkNO5o8UO1
	nK2V+Pd4rO5gkG4IZhbjZkZnmBKOp0KusWbXtNK8gZZWBfeaC9+YJPQDvZPR6IDeV9xagE6YVrR
	+xDh1qgVAf08c3Ce5H5ocv/8AhsbJyUV3Effk
X-Gm-Gg: ASbGncsHygZ9ZaDzkVRTjqL6xKwFPOBXL0FHM9m87wHlJ6wdNNNYJWNJacLKLx7We6m
	0yV5awQ6XMWFI8vwr2XWGZYRCPmIUhh9+OIwoRETYp/CRv9sdlg72daxt47c8R3CKB0eq/sDF+u
	VGkMORzbmawrv7ihq7WGqNL3Q=
X-Google-Smtp-Source: AGHT+IE+PT54dW/jFfbUFQKF2f7S0pRMSq9zC1UVzRGsX4g1egcYIwCf8Zk29pQQpvxfkAOvORhNMSOR9ksDvmVt84E=
X-Received: by 2002:a05:6402:354e:b0:5dc:7374:261d with SMTP id
 4fb4d7f45d1cf-5eb80cc8f1bmr5687587a12.7.1742459245424; Thu, 20 Mar 2025
 01:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319084050.366718-1-pandoh@google.com> <20250319084050.366718-8-pandoh@google.com>
 <2c71292f-dcbd-b00f-36da-fb1a9747427c@linux.intel.com>
In-Reply-To: <2c71292f-dcbd-b00f-36da-fb1a9747427c@linux.intel.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 01:27:14 -0700
X-Gm-Features: AQ5f1JqYAwryPeg56hpkNFAelhGfn0KgIFEurgBe50DJAAH0cOfbzQfQJvpIdf8
Message-ID: <CAMC_AXXL6zXo+x8t8MgxaSBfg4NXHesr8giSMirwfFpGGHc80A@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] PCI/AER: Add sysfs attributes for log ratelimits
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 2:51=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
> Why does the next patch immediately modify this? A patch series should tr=
y
> to avoid back and forth changes like that.

Ack. The intention was to make the patch as small as possible.
Squashed patch 8 into this patch in v4.

Thanks,
Jon

