Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D10742E61D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 03:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhJOBX4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 21:23:56 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:36845 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhJOBXz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 21:23:55 -0400
Received: by mail-lf1-f41.google.com with SMTP id g36so17971460lfv.3;
        Thu, 14 Oct 2021 18:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hTSSI6S3CgDLvq1yJ9mSPNuVClwcsV8040nZfSXnM8U=;
        b=N1I6OyNSTPt2Aa3B3A72BO4ABKQ6sb9HobgeQOTLd+mnil5nmV/QNcqOV3lBCBcgkd
         lijJWVj93I7iQ5QNPgfV80pAkwDkfcrFxLXvDIuOFLJaD1sHHNafFUpG605KN/RHJRB/
         Em0Opo27ZIta0MKhFn+mjgzzNEPvpkzTdZVPZ9PV7tDtK1QyRuRQkVFPs/F1p9Lbul0K
         JEfMs19itjScyStmBxi9Yq/DHDpFiv5pSDkbmOjsDjN0jJ0QFl/sVcjEjNfq46ACw9Sj
         0aCtNLVzNpUqbgjDHBqo1GB5UgvviXcASTuwLdXF587cnASe4GW48KiLXdeJ2F/k11eO
         VeoA==
X-Gm-Message-State: AOAM532YUoD37MV5DYjafHq4wiKaEwiRn+lrGL78cp5MmTBox2Tg9nUV
        moMp8uf0w4AVmz38Zpl/mNc=
X-Google-Smtp-Source: ABdhPJx0RsLZo3kDfLbLNaJ/h1VR5w6XyrRB5JU/hZhytYo5sPLeONzwuEQ2tzmWzenwyaH7RvoIjA==
X-Received: by 2002:a19:c1d2:: with SMTP id r201mr8221619lff.364.1634260908960;
        Thu, 14 Oct 2021 18:21:48 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id i27sm362865lfo.173.2021.10.14.18.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 18:21:48 -0700 (PDT)
Date:   Fri, 15 Oct 2021 03:21:47 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     kelvin.cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kelvincao@outlook.com
Subject: Re: [PATCH v2 1/5] PCI/switchtec: Error out MRPC execution when MMIO
 reads fail
Message-ID: <YWjXq/NL6zex4oeR@rocinante>
References: <20211014141859.11444-1-kelvin.cao@microchip.com>
 <20211014141859.11444-2-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211014141859.11444-2-kelvin.cao@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kelvin,

Thank you for sending the series over!

I am terribly sorry for a very late comment, especially since Bjorn already
accepted this series to be included, but allow me for a small question
below.

[...]
> @@ -113,6 +127,7 @@ static void stuser_set_state(struct switchtec_user *stuser,
>  		[MRPC_QUEUED] = "QUEUED",
>  		[MRPC_RUNNING] = "RUNNING",
>  		[MRPC_DONE] = "DONE",
> +		[MRPC_IO_ERROR] = "IO_ERROR",

Looking at the above, and then looking at stuser_set_state(), which
contains the following local array definition:

	const char * const state_names[] = {
		[MRPC_IDLE] = "IDLE",
		[MRPC_QUEUED] = "QUEUED",
		[MRPC_RUNNING] = "RUNNING",
		[MRPC_DONE] = "DONE",
	};

I was wondering if there might be a small benefit of declaring this array
state_names[], or list of states if you wish, as static so that we avoid
having to allocate space and fill it in with values every time this
functions runs?

The function itself if referenced in few places as per:

  Index File                           Line Content
      1 drivers/pci/switch/switchtec.c  159 stuser_set_state(stuser, MRPC_RUNNING);
      2 drivers/pci/switch/switchtec.c  178 stuser_set_state(stuser, MRPC_QUEUED);
      3 drivers/pci/switch/switchtec.c  206 stuser_set_state(stuser, MRPC_DONE);
      4 drivers/pci/switch/switchtec.c  567 stuser_set_state(stuser, MRPC_IDLE);

Even though the string representation of the state is ever only printed if
a debug logging is requested, we would allocate and popular this array
every time anyway, regardless of whether we print any debug information or
not.

What do you think?

	Krzysztof
