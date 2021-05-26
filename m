Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990D9391C4E
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 17:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhEZPqo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbhEZPqo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 11:46:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1748C061574
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 08:45:12 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k5so1023101pjj.1
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=FRxd18Nj9Hjdh6mMIDTx1A1KZXqkylQ6YcL2nYvICUM=;
        b=GbfjuyDRREFW5pnPcb8FgxaLDe6/sH3fhlQNpxq6U0PFtBebRfSMykX1yc/q6eg5Y8
         fOOD4cBc8mgirTDT9nAa3INZmc7HoxXuFqDi3jgVPzg6ATiXSTg165AooJ7RXEeJDZlu
         YN9nsRun7cw0EcIkNh6Ya4kC4ARVxAEQnvDjZJYgingpDSTIPOsrcXdFk0hox7MNIQS6
         QYDYCg17RH31gaOwbkWJyxQo92o/6Wz85doL1b4WgzCFfnrjE0rBweIUayTviQYDw3+V
         hUuSUSm7zgvZDAIpyf79kj84SVyDtOfgWjrdH+Kg0OAApMUfSC5u5HVwb6RTXjcVSAQV
         H/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FRxd18Nj9Hjdh6mMIDTx1A1KZXqkylQ6YcL2nYvICUM=;
        b=gbau0ljh30Gg761fyPCiDWY/8FI5WYEE9cm0UczmtlyfQePl+w+EPPYIuAZQytax5T
         0HpkfGmXOFj0zKWFWLZU9Sj7dsKNSu207NAR/9lcJ6peokDH8ZzyWs2bH7fxN7kEB+y3
         huipPfaq+k8+Rk2xw2dvXAPTiEac4RTz+RNzRHwgFOjcae0zGpZPPKOPO58abFWCPMH/
         gm7+59JBA1Sr2V72UptgzeSGtif5D0kWj81BEH1fTQCS+de2FSMrOsN9K2ukhNfCUpqW
         GKHvQ6cv5sCchmdSUNG9704a8sSTaNNRWPUQsGyS3pjXg/sCdwuSR+ErQqo5r/nadIG/
         tR2w==
X-Gm-Message-State: AOAM531RE+9hCAzOnjzbmbuQW66ax3fQGvphWeSN791YTIh28eqqwAPU
        CQnlJ3t9danwcEILRZ9YujN+C75WIS3Vg2af6UxiBA2qItyZSg==
X-Google-Smtp-Source: ABdhPJwilCBjygq5eA+3cxBmsW5ayfoNfUgyUBZop5NxUaghNzLFMYkxthH0BV8BlyqLXgIv7CXPHeHmld8dFLUMuVU=
X-Received: by 2002:a17:90a:a011:: with SMTP id q17mr27979345pjp.125.1622043911299;
 Wed, 26 May 2021 08:45:11 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 26 May 2021 08:44:59 -0700
Message-ID: <CAJ+vNU0EhbeBdiuypzAB5FzcNqG3ytT9MJa14BBqF7oCDroaNg@mail.gmail.com>
Subject: PCIe endpoint network driver?
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greetings,

Is there an existing driver to implement a network interface
controller via a PCIe endpoint? I'm envisioning a system with a PCIe
master and multiple endpoints that all have a network interface to
communicate with each other.

It looks like the PCI Endpoint Framework has a function library but I
didn't see anything that looked like a network driver.

Best regards,

Tim
