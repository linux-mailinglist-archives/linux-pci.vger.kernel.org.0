Return-Path: <linux-pci+bounces-5724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D2289861E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 13:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BBA5B21A0B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 11:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9A98286B;
	Thu,  4 Apr 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eCOdlWUo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A45F7580B
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712230651; cv=none; b=YlogfLhfHlRfxeLMvVbCJ5YdK0uxNWKshN75M0EyDGSuSvWcoP/H0xYaNu+2r065nFvvaS6k5GxOMX6JRs13H8I3Fi1zXgmg2y8n1QWShMM0+op+uz2lPN8oMT+SCDtQRffFPs+pEjyGEGEX8N+hWaHrxBQpPTkkLyjIuomWtzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712230651; c=relaxed/simple;
	bh=DAlReTr7FMZy3ybYtHJ3qg5jeZHN2W6oGUcghBVEMgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1cCA3bthrGUJ9DFQ4AlWvUKAVGunkcfyHcBRbHRolsiX2rlFbjHo+iVL4GMy8Uc5PrKR+/NwoH1dLjvglf/rHIXgbpCKvE0MecVE719ZjIIhwh0ZMHtaNx+V5iAE4qdEK0pCRCeh5D3SXM8KXg9g8Enjo6ckXXZBYWEv775fvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eCOdlWUo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51969e780eso10435466b.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2024 04:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712230648; x=1712835448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VO78M6WJ/EUoT8fizWFXUB5hyrVQ/HkiQuOMAjpL0QA=;
        b=eCOdlWUoy10DOFnS1LZrYeumky0sgH3LNAi9HV3vSH1ztOHp2ijDR984xtqc8X/USY
         2rJIZOvZnfFAaG3RTLv2oGVCjgzHBsuI5w1+vVZL4SWtdibW0ODAU3Wq1E7izryEUnaN
         K82khJwR0Xy5XmG0fhWZZuVAKQHR71qD5z+BH/DuG8hZI2sx/OEM3vo2+YrcBpc3aMoy
         UjgsnhO/CTuoARIsBY8JMZQoW0bCz8D8LugK1TqD+l50Oi8WPcusfedPAioWn4SG9yGM
         oluEFimXoQ1e2ivy6++MasQxZfB3uJdn3DZiGDS+TQgoy1dDFsj38M6xun2/Stmv+b7v
         BsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712230648; x=1712835448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VO78M6WJ/EUoT8fizWFXUB5hyrVQ/HkiQuOMAjpL0QA=;
        b=sZfupv7ztmD7d99XAkrXNs23DT1GOHUYlMxzJD5UIVjTF/CFhSnidvKSjgGHVZAKOF
         B85iHAfG9B/B6M5sLZqxhhc5rcCc8b1mUQxn2HYDjzKvAf8Retp13EnCo7hOHXQhvwBk
         W4W2tsHAP+rI4cIwUg6JrU+AxXUOPK37QuvletIjpFpslWdU1DAG/jQWR/49QXOlb/LQ
         I92A84f6ctHsAyLb730i+dGvfwtrpZub4H4CLlQ0oq+JmZJLm8eSvBWBMkSszRtyMP4v
         K9tKx69speA/pn0FxeopI67IKlfghV7QgV5+8DxgPDJlS7EySrHz5rUowpicQdr/42zM
         vMzA==
X-Forwarded-Encrypted: i=1; AJvYcCUxLM8lRhhLM03LZ7Ej4Bym2ud3iB00/tlVeE6gIyvtEz+LFbJE8mfU8Af8mPpcDAQhlKZVdp3MBbtiyMC35lGKl37zEKLhKnk+
X-Gm-Message-State: AOJu0YwEZdMNUPYH1VoweWpyPs2EowSCY++FpmcOn65uZtrVG4Dxn/24
	2eLWobYzkoDKXdFqvS6DHubwM2ZmE4ByqrnAfcG2B4qNKnVlTeBeYkn5u+H6Unc=
X-Google-Smtp-Source: AGHT+IHFHCHr2Q489DOL+d0gABB3LAj+ru+7apqX40Da8X9E+f+oK93EZhhaa5LxrlyPNiBsG0a/GQ==
X-Received: by 2002:a17:906:c313:b0:a4e:37ac:79c8 with SMTP id s19-20020a170906c31300b00a4e37ac79c8mr1489073ejz.5.1712230647502;
        Thu, 04 Apr 2024 04:37:27 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ak1-20020a170906888100b00a465a012cf1sm9079533ejc.18.2024.04.04.04.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:37:26 -0700 (PDT)
Date: Thu, 4 Apr 2024 13:37:21 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <Zg6Q8Re0TlkDkrkr@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>

Wed, Apr 03, 2024 at 10:08:24PM CEST, alexander.duyck@gmail.com wrote:
>This patch set includes the necessary patches to enable basic Tx and Rx
>over the Meta Platforms Host Network Interface. To do this we introduce a
>new driver and driver and directories in the form of
>"drivers/net/ethernet/meta/fbnic".
>
>Due to submission limits the general plan to submit a minimal driver for
>now almost equivalent to a UEFI driver in functionality, and then follow up
>over the coming weeks enabling additional offloads and more features for
>the device.
>
>The general plan is to look at adding support for ethtool, statistics, and
>start work on offloads in the next set of patches.

Could you please shed some light for the motivation to introduce this
driver in the community kernel? Is this device something people can
obtain in a shop, or is it rather something to be seen in Meta
datacenter only? If the second is the case, why exactly would we need
this driver?



>
>---
>
>Alexander Duyck (15):
>      PCI: Add Meta Platforms vendor ID
>      eth: fbnic: add scaffolding for Meta's NIC driver
>      eth: fbnic: Allocate core device specific structures and devlink interface
>      eth: fbnic: Add register init to set PCIe/Ethernet device config
>      eth: fbnic: add message parsing for FW messages
>      eth: fbnic: add FW communication mechanism
>      eth: fbnic: allocate a netdevice and napi vectors with queues
>      eth: fbnic: implement Tx queue alloc/start/stop/free
>      eth: fbnic: implement Rx queue alloc/start/stop/free
>      eth: fbnic: Add initial messaging to notify FW of our presence
>      eth: fbnic: Enable Ethernet link setup
>      eth: fbnic: add basic Tx handling
>      eth: fbnic: add basic Rx handling
>      eth: fbnic: add L2 address programming
>      eth: fbnic: write the TCAM tables used for RSS control and Rx to host
>
>
> MAINTAINERS                                   |    7 +
> drivers/net/ethernet/Kconfig                  |    1 +
> drivers/net/ethernet/Makefile                 |    1 +
> drivers/net/ethernet/meta/Kconfig             |   29 +
> drivers/net/ethernet/meta/Makefile            |    6 +
> drivers/net/ethernet/meta/fbnic/Makefile      |   18 +
> drivers/net/ethernet/meta/fbnic/fbnic.h       |  148 ++
> drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  912 ++++++++
> .../net/ethernet/meta/fbnic/fbnic_devlink.c   |   86 +
> .../net/ethernet/meta/fbnic/fbnic_drvinfo.h   |    5 +
> drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |  823 ++++++++
> drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  133 ++
> drivers/net/ethernet/meta/fbnic/fbnic_irq.c   |  251 +++
> drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 1025 +++++++++
> drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   83 +
> .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  470 +++++
> .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   59 +
> drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  633 ++++++
> drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  709 +++++++
> drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |  189 ++
> drivers/net/ethernet/meta/fbnic/fbnic_tlv.c   |  529 +++++
> drivers/net/ethernet/meta/fbnic/fbnic_tlv.h   |  175 ++
> drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 1873 +++++++++++++++++
> drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  125 ++
> include/linux/pci_ids.h                       |    2 +
> 25 files changed, 8292 insertions(+)
> create mode 100644 drivers/net/ethernet/meta/Kconfig
> create mode 100644 drivers/net/ethernet/meta/Makefile
> create mode 100644 drivers/net/ethernet/meta/fbnic/Makefile
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic.h
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_drvinfo.h
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_irq.c
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mac.c
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_mac.h
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_tlv.c
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_tlv.h
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
>
>--
>
>

