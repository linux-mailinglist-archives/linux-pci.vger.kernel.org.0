Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7351E3B1B06
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 15:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFWNZx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 09:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhFWNZw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 09:25:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2782C061756
        for <linux-pci@vger.kernel.org>; Wed, 23 Jun 2021 06:23:33 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h2so3484072edt.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Jun 2021 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=icz3yVZaBKoKX5vfFzNoQ1deA5c6HrQTyBzJ3S/dmpU=;
        b=Nd8BGvHG4fkZSwrvHa0V54ds3E7zPyQ5lfq56LFsxQUsJR+m+XtJRBJVEEMNKehrjQ
         dHlHp8TgEwSXX0e/IpLjB2csGXnZ+bvWy8R2VIldz/oaoebFRfRLHIBxzJF0VybbrgWw
         POWSTxS2tTDWN25hCnLhwb7bDHhY+VznvfubBIdwh/dWK7CCXdGelLyQxRM6XjlyOAbb
         0t9u53ys5llAj527SRTdmk0wd/hp3tVipUTRXyVLHsRFcU3Jy2WlUvZDtUup/86qFvm9
         iyyUzk3MdplNg4FbpcpTVqb0skmLm8ZucI0+NXcgLhkWakVwvBdotHfNL8iXAWHYJbFA
         uznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=icz3yVZaBKoKX5vfFzNoQ1deA5c6HrQTyBzJ3S/dmpU=;
        b=PCMwlxeesgr1zfNBo1vY2uSfKeGbmywxPW9xatNOhcR1n1E53g596eyeucvCe4uWqO
         fZ9EYBmfjJd3573HXiqxAW4MB6nqUHMDRk7qxybM8HlbNvfuJ843i5lvYzplxh9lo4yR
         chDP8yph66m2wfNW77fenlN2M/RNEeQa6AtsPr1J7mMmHostUx8jfU+3aYsGY9upQduh
         yYphNnfl1ll6dL1rcuHIP+CR5O6i9kG9JBT0wb34+sHjLcjKkrMEj0XUqQJtlrLcrcfD
         PW8qrENSe3FS/ApOP2AOCawRETKefjn5Fqyc2UuoNRzot1EOvAs9Rt/WwdmOWsDdr80f
         0JFQ==
X-Gm-Message-State: AOAM533AgJyb91bOxZGvt5PU00jVD+XT8urUFFuUFOTUH2LzFJhdyTG9
        2xfuSRBdjMJjo8bnzuJPq54bmg==
X-Google-Smtp-Source: ABdhPJyhXeGkzrD7cnNNDLRAfHQBWl7KLjfXWEQOkdCJPTp+0+bGmwSyem9kK6cjSI+v6rQFtDRwmA==
X-Received: by 2002:a05:6402:53:: with SMTP id f19mr12470179edu.200.1624454612307;
        Wed, 23 Jun 2021 06:23:32 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id b24sm1814916ejl.61.2021.06.23.06.23.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jun 2021 06:23:31 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        bharat.kumar.gogada@xilinx.com, kw@linux.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ravi Kiran Gummaluri <rgummal@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 0/2] PCI: xilinx-nwl: Add clock handling
Date:   Wed, 23 Jun 2021 15:23:28 +0200
Message-Id: <cover.1624454607.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

this small series add support for enabling pcie reference clock by driver.

Thanks,
Michal

Changes in v2:
- new patch in this series because I found that it has never been sent
- Update commit message - reported by Krzysztof
- Check return value from clk_prepare_enable() - reported by Krzysztof

Hyun Kwon (1):
  PCI: xilinx-nwl: Enable the clock through CCF

Michal Simek (1):
  dt-bindings: pci: xilinx-nwl: Document optional clock property

 .../devicetree/bindings/pci/xilinx-nwl-pcie.txt      |  1 +
 drivers/pci/controller/pcie-xilinx-nwl.c             | 12 ++++++++++++
 2 files changed, 13 insertions(+)

-- 
2.32.0

