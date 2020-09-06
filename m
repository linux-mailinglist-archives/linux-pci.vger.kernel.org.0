Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07B325F0FE
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 00:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgIFW6u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Sep 2020 18:58:50 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45902 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgIFW6u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Sep 2020 18:58:50 -0400
Received: by mail-vs1-f66.google.com with SMTP id a16so6435498vsp.12;
        Sun, 06 Sep 2020 15:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=l9gU3HORtrRH+vkCXVfjmCtqxxfcJ3UmiJuWg+ttTz8=;
        b=O0Cy6aRepQwXuzLJNL49GE59f0BgOOW1PTgGKwKftTMLA8Hrzo1lyywdJMJD7yJy6t
         K2XYtCwkH9anDut8+4zBvpJYE33xeUuAvadqsab2y2qJe3xX3dAcyrUKAzm6Brjcbjjr
         POp02EZNuTOz3QVlLLKVZ4CyFlb2YVYR9k5BZBd98dctuRLLtTFxcNbYFr3LBgOHFHeM
         lf2BFLU8Drqf+YL+0a4VHUIYcWhKwDHtcbPpByggHMROg+rzrc9/P5O4inT+hMmDSNma
         7r7vYabBwzgGFfTGPZzWhNWAJDSb7EkK+umaJjlpvVscJgTuA0WPBktoL8xqjep0eLYc
         Lmng==
X-Gm-Message-State: AOAM5318JtcKYSsbum9XxNdms/jKQqRz8z8/N5eBaS/HsvNARxQ29S6C
        r1Ctt1AfMa33dZGOm8NSHhV1fIyJDKZiQiPXzAypeL0PwFg9PA==
X-Google-Smtp-Source: ABdhPJwIuoHtuYZ8x7Z4bI1wN3KTd+OzO5nC9w+llh29UCXFhUJKfRjU4Xm363cKbA+qVk1YVk52m6Cpck8rHrOtfIg=
X-Received: by 2002:a67:324f:: with SMTP id y76mr11008595vsy.20.1599433128959;
 Sun, 06 Sep 2020 15:58:48 -0700 (PDT)
MIME-Version: 1.0
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Sun, 6 Sep 2020 18:58:37 -0400
Message-ID: <CAKb7UvhqZMcL3UNbK-6ZG9LJddCmoL0paYsRx6+5bVKDQpAjmQ@mail.gmail.com>
Subject: Regression with "PCI: qcom: Add support for tx term offset for rev 2.1.0"
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ansuel,

I'm on an ifc6410 (APQ8064), and the latest v5.9-rc's hang during PCIe
init. I just get:

[    1.191861] qcom-pcie 1b500000.pci: host bridge /soc/pci@1b500000 ranges:
[    1.197756] qcom-pcie 1b500000.pci:       IO
0x000fe00000..0x000fefffff -> 0x0000000000
[    1.205625] qcom-pcie 1b500000.pci:      MEM
0x0008000000..0x000fdfffff -> 0x0008000000

and then it hangs forever. On a working kernel, the next message is e.g.

[    6.737388] qcom-pcie 1b500000.pci: Link up

A bisect led to

$ git bisect good
de3c4bf648975ea0b1d344d811e9b0748907b47c is the first bad commit
commit de3c4bf648975ea0b1d344d811e9b0748907b47c
Author: Ansuel Smith <ansuelsmth@gmail.com>
Date:   Mon Jun 15 23:06:04 2020 +0200

    PCI: qcom: Add support for tx term offset for rev 2.1.0

    Add tx term offset support to pcie qcom driver need in some revision of
    the ipq806x SoC. Ipq8064 needs tx term offset set to 7.

    Link: https://lore.kernel.org/r/20200615210608.21469-9-ansuelsmth@gmail.com
    Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
    Signed-off-by: Sham Muthayyan <smuthayy@codeaurora.org>
    Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
    Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
    Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
    Cc: stable@vger.kernel.org # v4.5+

 drivers/pci/controller/dwc/pcie-qcom.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

And indeed reverting this commit on top of v5.9-rc3 gets back to a
working system. I have no idea what PHY_REFCLK_USE_PAD is, but it
seems like clearing it is messing things up for me. (As everything
else seems like it should be identical for me.)

Let me know if you want me to test anything, or if the best path is to
just revert for now.

Cheers,

Ilia Mirkin
imirkin@alum.mit.edu
