Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B876E34A429
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 10:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCZJTB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 05:19:01 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:34454 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhCZJSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 05:18:31 -0400
Received: by mail-wm1-f45.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so5564547wmq.1;
        Fri, 26 Mar 2021 02:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Mvur1GUmH32VOUskwiW2+EcCiaYg3WjBaEKZm/xa40=;
        b=GBfg7xzsihRxvEYOa3sX5cdsQv9gZldhG8Zw//WPqB4O1sDsOdOJRDtv2NOybrghil
         2crljWr3s9lWUO9LtJrKTC1pvEFb26FBJmJlvUOLYz6lS7yanm2pXIjQ3kJ0U7T6cGyL
         OYCfKbWIcKGBZ/COpDnTOrPH6UjmdZkMKE8Cbkf4pKBxG7TzSwO7Qp7lfIpdc060x7/b
         WTkkn1EH2ZeEotQmz/dXMPwDtPw1kqlquoRa7TiJhmJ8yGfmPAvUXBg0VsCTCsXseQPz
         iPW+k/u56cyvdZ9Ek6PGJm7qgtaWVYu4l6sHlzA2nVjah89sdp6md9PwxPJ1sYvZxxJj
         zGRg==
X-Gm-Message-State: AOAM530Oe7DIZPxPK6HdLYZaKB27L8NHGov0z1QR80AXenlu4G3ng3HA
        xZ2AC2EtXQL53QOj8//t04A=
X-Google-Smtp-Source: ABdhPJzQHRy22NwuSChpb7o0Yk5ORNyrLm9BNNmztYbg5Iaw5u2G4Bcshu7y+mCsBluieKZTKYG1kw==
X-Received: by 2002:a1c:2683:: with SMTP id m125mr12068344wmm.178.1616750307615;
        Fri, 26 Mar 2021 02:18:27 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id h12sm5199389wrv.58.2021.03.26.02.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:18:26 -0700 (PDT)
Date:   Fri, 26 Mar 2021 10:18:25 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        alay.shah@nutanix.com, suresh.gumpula@nutanix.com,
        shyam.rajendran@nutanix.com, felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YF2m4amcwj9BkQ+S@rocinante>
References: <20210322111003.50d64f2c@omen.home.shazbot.org>
 <YFsOVNM1zIqNUN8f@unreal>
 <20210324083743.791d6191@omen.home.shazbot.org>
 <YFtXNF+t/0G26dwS@unreal>
 <20210324111729.702b3942@omen.home.shazbot.org>
 <YFxL4o/QpmhM8KiH@unreal>
 <20210325085504.051e93f2@omen.home.shazbot.org>
 <YFy11u+fm4MEGU5X@unreal>
 <20210325115324.046ddca8@omen.home.shazbot.org>
 <YF2B3oZfkYGEha/w@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YF2B3oZfkYGEha/w@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

[...]

Aside of the sysfs interface, would this new functionality also require
anything to be overridden at boot time via passing some command-line
arguments?  Not sure how relevant such thing would be to device, but,
whatnot reset, though.

I am curious whether there would be a need for anything like that.

Krzysztof
