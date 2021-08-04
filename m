Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C588F3E0850
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 20:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhHDSwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 14:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhHDSwH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 14:52:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A97C0613D5;
        Wed,  4 Aug 2021 11:51:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k4so3376287wrc.0;
        Wed, 04 Aug 2021 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pi5vfFB9VGjbPC/jPcgkf4sqY7qXZIiD7RZnvzubQOM=;
        b=QfCFqzlMHM9+W6k4KRRcD7KlDKWpWLeBqVqmVmbels5kfEQnGkioLf+ja8a72o0B1V
         uawYBriDrwrrKQDora/xJDhwkBEnnSFQnPyCzMqctamGL0q9UW/yWMT5fe6dAWq0nNyw
         GQrv3L79Jl/4vr7oHKu5sdGZHyVSlgc4P5Tkz5QDAd8kvlMLUDBMXpsy/MZ/DRYuBt5m
         GmWxoiPs8u+im2KYVxva25KPKeoM0UmynHAXk3hlTTML7k/iqdHrWEJg7JIDKryDaqUf
         0ojTb5Xzuq+z+wKxu+WCdgz6mlVqCe26T1ZtDFKGI7UoTB4tn10nOS3mkuRNXItt84oQ
         d0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pi5vfFB9VGjbPC/jPcgkf4sqY7qXZIiD7RZnvzubQOM=;
        b=KzkQcrur6hpK1BfxJll9Fppppe+EjyWy+w7X9X4ZB9Uz5M/CyrbgeyR7+5grXFQPz0
         cgmtoTy2XywTjb5IAFVMtw9z4iag0AVKZwJPVBLTv/fdyuML7kbwa/enn2skew82gqFm
         MpHk9wo+4v3jvsWDBeZlLLS8AOMwq7AAMRKvM8CMbkYKTShZwxp6FScjXeS0Ggt8lrTe
         JcHPN0RxEyiOx63mZsXxfQkkmSPZPiumTIM4R4j6+rgxmiQRGTO6yLyg4aZ8RTRMI9+3
         FIo7uaZG39lZ92O8HmkBZS9VksXTgCEpGPzW/mZfajdD9OyT1nys6R4dsF+6JuJQN9hr
         boPw==
X-Gm-Message-State: AOAM532MF4mF0BXHvVU32zNU1BYLlcK2Wwhy01BLM8KRqa3JqPWU0Zfy
        HNhW8DHkPbPLpbBezRmTJ70=
X-Google-Smtp-Source: ABdhPJznpaFJTyvvmaVzZ3cJK522sDPgQxB+6YZGaRj9CUGSofohnaknYQ3rDv2WxO1d+ZCFbxwg/Q==
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr784171wrs.178.1628103113528;
        Wed, 04 Aug 2021 11:51:53 -0700 (PDT)
Received: from localhost ([170.253.11.129])
        by smtp.gmail.com with ESMTPSA id s9sm3493607wra.80.2021.08.04.11.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 11:51:53 -0700 (PDT)
Date:   Wed, 4 Aug 2021 20:51:52 +0200
From:   Sergio =?utf-8?Q?Migu=C3=A9ns?= Iglesias <lonyelon@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: probe: Fixed code style
Message-ID: <20210804185152.nuk3gfszq5l3clbq@icebear.localdomain>
References: <20210804144219.791004-1-sergio@lony.xyz>
 <20210804164007.GA1648919@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804164007.GA1648919@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks a lot for replying to my patch!

> Read https://chris.beams.io/posts/git-commit/ and
> https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

I should have read that before posting, sorry. Is there something mayor
I should change for my patch to get accepted?

Thanks a lot again for replying,
Sergio M. Iglesias.
