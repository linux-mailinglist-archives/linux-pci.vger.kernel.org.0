Return-Path: <linux-pci+bounces-6002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 598C289EC82
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 09:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BF51C20C46
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 07:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F46113D2A8;
	Wed, 10 Apr 2024 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CaCJ8AJc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A513CFB3
	for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734940; cv=none; b=bKR95VjDl/cAlsRWpepA1Xsx3irccEWYLQvwBfBz/Ko3E+4MQJluLQ2lxWKR3iUTMhXgMC6MRq+5f/4TfWYWauwzxp0F/HbL6F2kZbqPDH+eTfTuLd/Wvx4egVOQlo7POnCMtRsVZ2Trj+AlND64eOhUc+eG2P//pu79Fc0VMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734940; c=relaxed/simple;
	bh=kztqXTJAoSz+e/mj1kuKESJlzUgr1+yO6Mcuo2khv80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAxQwkrSaJb3gTrEL3wK++WrcVvVS9wPt3KJcEewScMFQW7oot0ls1BU5HzUsV32GomHJysicj8gb9nm7E4dDcsOeEzPGp/ghv0HmqcJZhCXm3aa+oCx0DlQ37s6EBP0xYZLY8blTkfh0HvWeGG/MYaDxad81cMXu2rrvTWYJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CaCJ8AJc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4702457ccbso821787666b.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Apr 2024 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712734936; x=1713339736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y//drBcHk8K2aIKsW3skZ7g4m243pzURRAAm6EHv+Vo=;
        b=CaCJ8AJcInWzOxvJwxd5KYv0dkEtACSAMPcTnk07OUkHfQIPsr8G5zcbroZWQ08bFD
         TGj3F7zGEBkzZ07w8IXejXfGNp1duJdFSpfzCUVcsTvJp1xBai+in52Yi0tnWFP3SQcT
         2A5qXb0zxCwha9kjBQH5J+Alky7VeC4cELgHIW92XM4+Mn3a4tr6ZS+RmtU6zCFsziay
         3jGlxy/hIK/98ltMNsR4FwSC+ULIrBpLkLlRQfrhM4zJSz7ejk6BRXb8gC/mhAbIACN4
         6thdLOnmKjNCNk2sQKpmeM08WZir5F1vYJIl3YVRkWhPs3P/WdyiGCQoWyUEiivMaDk0
         m0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712734936; x=1713339736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y//drBcHk8K2aIKsW3skZ7g4m243pzURRAAm6EHv+Vo=;
        b=Qrd1iVryOnVwkJaOiliDxf+q4lnxQA+0iSB/Dinj2nvp8Pk5bmgfXIBD21zYhfjDXb
         eIRMbwUvDPDFa3gg/bwrG6XMXlij8kg2rGQ1p17HGPIx4kx1tWlTHl5ArSRMzCSTldTr
         SDInPG/dtLNoDpCwyBVAXJnvGBiG0WVO1LexzDLAJ93i5rYA9Yeoap720E48VknN6q4o
         XhdmppftQA2ozKw/BhIwgy/0EbDRNzHtBPSO1viExXGMVlykbvQMbalVLewmI0h2Bpss
         CYnw4+hbkKsC3UenkuxekuXiUPdrk9cMMnBTx83YEyQQLTAG0GTecK46sFJFkR2lk0qt
         Z0tg==
X-Forwarded-Encrypted: i=1; AJvYcCUwF4SfMYg4Ib/JF16Wdl00E1NbzeplTnFnXy+VYpWbTUKjPk7+AAKlNhCm8KYYI38BOXg4anE16M3r/UC3I3A1Qztw4f8xcpdd
X-Gm-Message-State: AOJu0YyYU8mWHtf+NqpyHaGKa021R1xDOTYZRbFUnx2evfExpmqlLFL0
	TU+kOrNYTP/VwQ8wGwE9sz+uydCjAkEIk+cfpF2ePecmR0AJaetPg475i3mywxc=
X-Google-Smtp-Source: AGHT+IGfZsCjrYN8kp3I8JH38RfST/SpsvUGrNp8ERPfOLl+fqXHnm7ZKPgfclYor4Uat0DIcfMB1g==
X-Received: by 2002:a17:906:6d51:b0:a51:a10c:cc3 with SMTP id a17-20020a1709066d5100b00a51a10c0cc3mr1087478ejt.17.1712734936215;
        Wed, 10 Apr 2024 00:42:16 -0700 (PDT)
Received: from localhost (78-80-106-99.customers.tmcz.cz. [78.80.106.99])
        by smtp.gmail.com with ESMTPSA id k12-20020a17090646cc00b00a4e3fda23f5sm6588972ejs.165.2024.04.10.00.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 00:42:15 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:42:14 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhZC1kKMCKRvgIhd@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409135142.692ed5d9@kernel.org>

Tue, Apr 09, 2024 at 10:51:42PM CEST, kuba@kernel.org wrote:
>On Wed, 03 Apr 2024 13:08:24 -0700 Alexander Duyck wrote:
>> This patch set includes the necessary patches to enable basic Tx and Rx
>> over the Meta Platforms Host Network Interface. To do this we introduce a
>> new driver and driver and directories in the form of
>> "drivers/net/ethernet/meta/fbnic".
>
>Let me try to restate some takeaways and ask for further clarification
>on the main question...
>
>First, I think there's broad support for merging the driver itself.
>
>IIUC there is also broad support to raise the expectations from
>maintainers of drivers for private devices, specifically that they will:
> - receive weaker "no regression" guarantees
> - help with refactoring / adapting their drivers more actively

:)


> - not get upset when we delete those drivers if they stop participating

Sorry for being pain, but I would still like to see some sumarization of
what is actually the gain for the community to merge this unused driver.
So far, I don't recall to read anything solid.

btw:
Kconfig description should contain:
 Say N here, you can't ever see this device in real world.


>
>If you think that the drivers should be merged *without* setting these
>expectations, please speak up.
>
>Nobody picked me up on the suggestion to use the CI as a proactive
>check whether the maintainer / owner is still paying attention, 
>but okay :(
>
>
>What is less clear to me is what do we do about uAPI / core changes.
>Of those who touched on the subject - few people seem to be curious /
>welcoming to any reasonable features coming out for private devices
>(John, Olek, Florian)? Others are more cautious focusing on blast
>radius and referring to the "two driver rule" (Daniel, Paolo)?
>Whether that means outright ban on touching common code or uAPI
>in ways which aren't exercised by commercial NICs, is unclear. 

For these kind of unused drivers, I think it would be legit to
disallow any internal/external api changes. Just do that for some
normal driver, then benefit from the changes in the unused driver.

Now the question is, how to distinguish these 2 driver kinds? Maybe to
put them under some directory so it is clear?
drivers/net/unused/ethernet/meta/fbnic/


>Andrew and Ed did not address the question directly AFAICT.
>
>Is my reading correct? Does anyone have an opinion on whether we should
>try to dig more into this question prior to merging the driver, and
>set some ground rules? Or proceed and learn by doing?
>

