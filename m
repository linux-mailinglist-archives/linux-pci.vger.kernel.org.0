Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89C3345CFB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 12:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCWLeB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 07:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCWLdo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 07:33:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FFCC061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Mar 2021 04:33:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id f26so25137799ljp.8
        for <linux-pci@vger.kernel.org>; Tue, 23 Mar 2021 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPVnvK6mMVs+UwQtfh3V/JXjjThVvv9VzdQ/PVOGABA=;
        b=q0buD60i0gX8uK1G77eVIYxtRHIG51y9urTrAmp+gCFqr7qKLDdzo0VQkH5DRimE7Y
         J6+8L+T+ScuxLPBfdZ+dQldA3V/nxWgoYPIwgLwabOl5KS8Wao/gXtun+5/QceuzHzXj
         VzO7LHao3bUTG9hAq3UTclUAHlM2FOKTEZRsk8p3dMDjLDEDJBn3F2gXAhXMoMlnskuC
         +EabKkqY7bIYZTJJcSJ2zaS50hDJ3sLr81wv/qLjk8GBaWeO0yPH74n1whdhucchVsNJ
         oJL+O3rgn5WObmf255YsrZWtc0d0MQFOHWGuDUBmHzk8WhM44J3ekDBn/d3dqbLWFzwS
         ZmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPVnvK6mMVs+UwQtfh3V/JXjjThVvv9VzdQ/PVOGABA=;
        b=YuucGtk4BJAskB9oTd/yUhGOI6AvPnGtR3aStNy9itAH4p8jrAX/PfK4HiVPOFEXmR
         2uSA8TuwH4TwP79hmfLQa5YscYWpDZ3n3ehE7WgA9zkUgBW3CXdK0/dTKZcgPfIrwbgY
         UUZd/qFu0uAwiDUTOFBng6uyHerOXZK141gEKrKEWdGNZ5t+ck3g+bywqM/RkHAP8Ucc
         miUo79pfVLwVx0Z8kECq6oswkQF5JqO+EkP6zOUNAIp/oxx8mYkTYH3Y6hnpnsXyQGNS
         poWTKLO/JDYIVFZC4sNBEya8TtJalFsNmGvHA21SMDMa50ur8lf2MWNyNaWue8segu9g
         qTFg==
X-Gm-Message-State: AOAM532Gcq5uymZjnrA5rkkOfkk4D5XR1vaOTDpfDnT+lqbH1z6Pa6lU
        xNei+xww5WOk1KM/YuprZ7xFwYoIz9VHBD52sqI=
X-Google-Smtp-Source: ABdhPJz9hxsv1C6/gOtM4hnE7MnO4Q2Iw4P9kO90L7NIvZiQ6f4RPlvye7b8gJ9S1xJ3XyMQRbJlsn/ul8tuKdo3uq0=
X-Received: by 2002:a2e:87c6:: with SMTP id v6mr2886956ljj.490.1616499222529;
 Tue, 23 Mar 2021 04:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210208174114.615811-1-festevam@gmail.com> <YDVxBzH/9ePDhy4v@rocinante>
 <20210323111010.GC29286@e121166-lin.cambridge.arm.com>
In-Reply-To: <20210323111010.GC29286@e121166-lin.cambridge.arm.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 23 Mar 2021 08:33:31 -0300
Message-ID: <CAOMZO5CPseH7MFk+k24W8eXuxQsZDwzTGMCQik-_XgpVjECH7g@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: exynos: Check the phy_power_on() return value
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Tue, Mar 23, 2021 at 8:10 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> Fabio, what's the plan with this patch ?

I will let someone who has access to this platform handle it.

Sorry, I have no time to address Krzystof's feedback.
