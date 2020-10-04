Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3005F282B2A
	for <lists+linux-pci@lfdr.de>; Sun,  4 Oct 2020 16:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgJDORn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Oct 2020 10:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgJDORm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Oct 2020 10:17:42 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D50C0613CE
        for <linux-pci@vger.kernel.org>; Sun,  4 Oct 2020 07:17:42 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u8so7853935lff.1
        for <linux-pci@vger.kernel.org>; Sun, 04 Oct 2020 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=P/JFHaNraPpxUew9uDi2BwheT94xssSB3xMj3UxWdGM=;
        b=BkRh6a99W3qHl5dZBnjR+mbI2bNiehYWniXMPg88tYmvZm+efkOqDbzwSk2cwllGnY
         2DneSGsaqLgOjTVZW3BcBdJEyEqojbMG2mhQbxq4VQ8NYpH4wIrVs3kFhId7F+9yP9Ib
         L7PNuoifY1kWe7omJhaSu4/oCoXWKZMB2qGgZTqkiVBEJgAhwS+ihN+6ftRTQLJN168j
         QX7wytcxw54wlNtq6/UHrkGuFOv1PdDjkHK8tv4EhjyD+xCEmHJT174/bOYQF9ZR3ko7
         Y2xfLAD/dU0Rgq46UuJN9AlsPVIYzA4VILaZQ4QQFdZzrl0DWKQ66DFEWpDJr4rCmK/1
         hzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=P/JFHaNraPpxUew9uDi2BwheT94xssSB3xMj3UxWdGM=;
        b=Z0IwtnLPMfEKzdghtIx7FL7egg4V7DoRfva4KsxawEmsZ1ia/n+uq4iZvWfNgjOO/M
         ZLKz/b2KBowONq1toYZ+ShsVSG6pRkmQIG+tef+jilDcmkPqNlhn9wckGm5Fneze5JXs
         5jXlRnjMbbZihgRyz4WRGfZHp2IeOqxYwkiHhPlWrZq33Gus/QuT/kYZuiv9tibd3Vd9
         ZysaxxdualrLlMiDR2nohPyNkdriQYO/YSztRsBBfS8fwVkCpKDTqbpiyZfQgmblcJUJ
         5TUkMxUt8NFV7wuzpkzwexcAvrLsPfHkwez3qJ0RHzA6c+S45hWIXXod7xSBR54H2PoB
         RkSw==
X-Gm-Message-State: AOAM530lWhJHNWwa89AbdEEEjir2qKMe+Fu8U9zVgAhY9AH4o9gNm/r3
        V3DNQGZ7R3BMKgDcJEMhKRZibv0AKvM=
X-Google-Smtp-Source: ABdhPJzIXxurLhvx/MJ9uYEr6qYdEZhMqBnydxPb48ixYIGR4rqBqJHMA1vgp/bTqhKg+4EvU+Zrqw==
X-Received: by 2002:a05:6512:682:: with SMTP id t2mr4412467lfe.201.1601821060657;
        Sun, 04 Oct 2020 07:17:40 -0700 (PDT)
Received: from mettala-desktop.elisa-laajakaista.fi (91-159-201-147.elisa-laajakaista.fi. [91.159.201.147])
        by smtp.gmail.com with ESMTPSA id f2sm2495020lfm.208.2020.10.04.07.17.39
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 07:17:40 -0700 (PDT)
Message-ID: <2b89febed2f0fe0e5d657e61148d06c0aa4c9e32.camel@gmail.com>
Subject: SATA SSD doesn't work before resume. IRQ and device id changed.
From:   Jouni =?ISO-8859-1?Q?Mett=E4l=E4?= <jtmettala@gmail.com>
To:     linux-pci@vger.kernel.org
Date:   Sun, 04 Oct 2020 17:17:39 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, I am triaging https://bugzilla.kernel.org/show_bug.cgi?id=209419
2.5" SATA SSD does not show up on boot but is visible after resuming 
from sleep as removable drive

It looks more like pci subsystem thing than sata. After resume:
Subsystem: Acer Incorporated [ALI] Device [1025:1422] is shown as
Device [0000:0000]. SATA disk then shows as USB disk. Is there
something simpler than suspend/resume to find this SSD? 

Is it good idea to reload some modules with parameters or boot with
some parameters?

Jouni

