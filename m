Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCD7E77CD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 18:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404186AbfJ1Rqb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 13:46:31 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:43147 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbfJ1Rqb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 13:46:31 -0400
Received: by mail-yb1-f181.google.com with SMTP id t11so1600129ybk.10
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 10:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fm6UcEQ1ztm8MPekKk4NDJMJWpJ6npCNx4OPevDfxNU=;
        b=ttscVjfHVnwAj0HjkPJ1MSmhLlirO/1x7QmLUyrLe5y+JjLTuR0bjE8U3o0M0qNLZa
         tJu27hrtqb2CubdpxbUPy4n1+YtvhhNW5Umsn82pt5OrAypdTzqY/H0whkbT0TO/9waK
         3krcvf79Y3e70z/Z773B561Y+bwm3zs4SeC+ShM5tkPvnkUzVpH601kl3salbrkfEPaR
         2cVEqa5jLeIIqTr7vmlhCDCcRN6d4K/pJYv86WNbYh/KYGVih1+97WgaJeekWkyt+3AC
         gOWlk3BFM1DrzAP9jf5lvPrEJqZGlBnLq4kjS6JpJ/Jfcq1xbhpb29cqsfBlmRlZKMif
         dHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fm6UcEQ1ztm8MPekKk4NDJMJWpJ6npCNx4OPevDfxNU=;
        b=aDXAPZCF2fhCGYdNkeFct28ldIhFyki8JvJGfnHIiegvfw+2Qn974qUAunVcR/+lKM
         wEl5LVTha1S7SHjG6X/IwuXmyJoyp1vbTw1ReOo9wr1AbjKWf+VLom8mqJw8UcROi7Pe
         /A7xtRhNWFTdsgM6hwcUavszKFMpdEqkjujcOyI1e6qiUHIwGp9mbdvF4uQ3tgTueIQk
         z/katOCMoyeiVwbNLQbTaVkA6Mb+bSskyNdImYV2rgrKGQo8sLPswPnO9MsGDekwa9ZD
         TOM3PBPE8OFHk71ioNpr4aZDYm2xjZxtXBRfZW2uw0TADv911K3rUWyZejJw++srLg1y
         uWTw==
X-Gm-Message-State: APjAAAXAxwya8pB6Q1kmc1aXK9wv8MKXA1jMWyZLjzW9Ji33EmHIIQiE
        tavAF7aj9aOXMqbyaiHp2UNbAgKxo4d5nH4DDvw=
X-Google-Smtp-Source: APXvYqzxDTwWYsbMc+DQifge53ErYqLNJgMghALeZHRi0JFTc+RkaRqcilz7197Q5V0ZVxdTE8ymUcZaCsl6dviXToQ=
X-Received: by 2002:a25:cdca:: with SMTP id d193mr15676829ybf.60.1572284790884;
 Mon, 28 Oct 2019 10:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QBN9C_o8HanAzXpDUN410g2o5+xfx64pbX3_VHVDKcj5N3kA@mail.gmail.com>
 <20191028171329.GA104845@google.com>
In-Reply-To: <20191028171329.GA104845@google.com>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Mon, 28 Oct 2019 17:46:11 +0100
Message-ID: <CA+QBN9DJ8X2tuShuTb+H31ASWfvWbx3VdCdyRxRkgaueZiitWg@mail.gmail.com>
Subject: Re: Oxford Semiconductor Ltd OX16PCI954 - weird dmesg
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

http://www.downthebunker.com/chunk_of/stuff/public/projects/sonoko-x11/devices/io/miniPCI-uart-4x-serial.png

This is a pic of one of the two miniPCI quad-UART modules.
