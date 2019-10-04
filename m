Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D6BCB68E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 10:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfJDIij (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 04:38:39 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:44173 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJDIij (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2019 04:38:39 -0400
Received: by mail-io1-f53.google.com with SMTP id w12so11718376iol.11
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2019 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YTeq3ZZo9UHM7xgnfv3IH0gfS45HOT33NlfI6uSAmO8=;
        b=0aFXMbuywcxOGi8k8wHUe1APcLePR/Owq48WIJRvCvzmpr++fy1QuNElW6vVNTefa3
         dl320enzxU2GGR3K+8RWoMu0HccTfdDmfKCPQtsNquFz1SXPjeVNEj03bJPPluxJ+AMq
         /2gemQUq+hAMQ+RuuQoMrkWaI2L00oAMBunK2uCh1/QDgYA9mgxO8edgpeyY5pN7s010
         bUZh5Vx/LKRfU3/B7Dgeunl6GWohikcMJEP9zYdr0TaSW/V1ZRkdjd7NhJ+3Jj2Q0/j2
         4xYR8cJG3e0OeWtaGQnNJo0EcCTx8jnAYCKosaW+0QmEUx6k5VXiYE5NLjzRSNxr7dvc
         FrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YTeq3ZZo9UHM7xgnfv3IH0gfS45HOT33NlfI6uSAmO8=;
        b=DhOXoI+0O2+RCA4I8jhDCsxDNffPHBtZh2UC4ynIjJfc9K6t65Z0FPGET3mSxB9NC5
         A+3MwkC96aRy6cr7NF8JnVaYVNQuNVOOZq3RyRyVYY8HWQY5a/Qfvp+DXeL7Qe0ggAEH
         Em1MbCE0ZjP1tVxPM7T5U1htGjgfYjCz3Jt6ur6ietRZYvZPNtmDtv9HqDsYwranx5RJ
         unuFWy4fHGKjBXPH+U5yPTvu/4VhByeKUzXeGS8HK3iqNwN74QPPHir9RFk2jMj9rFXp
         iojq8i1JSnulK01PHNyP0K+GN5qCXgCFTv0vgfipw7M3bZJs0xt6CWF4SkX8Z5HfxXPZ
         1F3w==
X-Gm-Message-State: APjAAAUOsTl0gDjMyXxhgVvhjsYBroLtHnlGjXDd4RyP35EwG/74pdk3
        tMgN2Z+bRCGE/w/Qnkqd+aUfnWiLFHohPMmnDJgnL5QI74g=
X-Google-Smtp-Source: APXvYqx4hyVjevixleIUIGxf2n0ExFJtHZ1tQicZ4HBqJdjrYVyEHWhy3rexaiapla0SjUlTqthkNfMCNeiF3bZI8/g=
X-Received: by 2002:a02:c65a:: with SMTP id k26mr13513357jan.56.1570178316858;
 Fri, 04 Oct 2019 01:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <1563279127-30678-1-git-send-email-jaz@semihalf.com>
 <CAH76GKMZy7z05Gc9HVDUkpM04+tXMa8xEEMBWMQ7Zx1Bt_B0xQ@mail.gmail.com> <20190930143941.GA3744@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190930143941.GA3744@e121166-lin.cambridge.arm.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Fri, 4 Oct 2019 10:38:26 +0200
Message-ID: <CAH76GKMTgv9R61+f5O1g6xXaaUfuV8e3i88jLp-z17miMQ8eWw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: aardvark: fix big endian support
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pon., 30 wrz 2019 o 16:39 Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> napisa=C5=82(a):
>
> > I want to kindly remind about this patch.
>
> I need Thomas' ACK on these patches to merge them.

Thomas, could you please take a look?

Thank you in advance,
Grzegorz
