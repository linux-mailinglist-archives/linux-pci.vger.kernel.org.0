Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58DE20309D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 09:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbgFVH1P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 03:27:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:45527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbgFVH1O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 03:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592810832;
        bh=+Ip11REy4BHUqrKIldsyQ0hoMMg0MGPJin6EmDd5heM=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=X0R9ypLR3N+35vQxdlBQp3Oo/lfH9CkxTWpjX25n1JafWPK1zHf5z1EBVRW65uf5v
         ADYBNCeNwsw9Q/2KQX8LG7FUWJYYZt8qNly7BqLZmINtgZ5dz58Yz/mY0EGiPAVSP+
         TZmlQ59HHknMdW8C3s+8c+8bdIqO9HfVL2YGLGsI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.11] ([84.114.190.28]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbzyJ-1jIKA32I9f-00da2d for
 <linux-pci@vger.kernel.org>; Mon, 22 Jun 2020 09:27:12 +0200
To:     linux-pci@vger.kernel.org
From:   grinko <grinko@gmx.at>
Autocrypt: addr=grinko@gmx.at; prefer-encrypt=mutual; keydata=
 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
Subject: Intel Ice Lake & Thunderbolt dock: disconnect failure
Message-ID: <4347ce60-7a4d-125d-6f98-88020002d19b@gmx.at>
Date:   Mon, 22 Jun 2020 09:27:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:z33YxAdsaCqAEvZxaotiGAPfIcACvVziw0FtfSpVWyMZx+07qdz
 9MR2QXXKghPGFS2jGMgppocst8CjbnWpO33jxv0+SjVnEZTZnBlZCwNbc7c2Sp3i9e9f4pJ
 aOVppbXs2JCJW24LfUt9gsktINWeUPp8IzoDOs3JVZ8wixsT7GuvITRIIJCY1FWWTHWAtgq
 FTfq7H5h3fV3PROiAci7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:W/4DFvPBSFE=:0Aq7FcyMnbVonrtQCGLbDa
 V/fZn9TEwJ+DYl1lHeqlHVQVkQeJp+8bV7IXHqUT6Gg8ahqDntyJcvPAG+urVU1pTcMsR3SsS
 FS3DznogXsSsTrv0ChlaCaCXQrP3i2Ros735t0S8F/Yhho8XR/YE9NvM68Ulyg2ODnrej836g
 Byom8QVMz5vfOLUqcGNFCkz+oaAYm7riZCa5xrynOLQs1Rjdy+mTJiyB4/RVnqmESfile7Fb6
 5+/05YYvURLULQdL1UP/QuHLH0u/j9SYDs5mYbwdJ3mc+5wY9Y3FBG+os8vUD4nsz78oogj8I
 arFmq7m4Sv6Q1d4+LCRjyOy7iWNBmAXRbOS4SsuAQmcywAS4bbhEFRZ5ZLjEc0wHn6eRrIw2f
 8Rt3zF4a8FdfqsAwQvR5cx66K5n57QXQhvURRFSREboMgDUSvHcTIWJLSlXznZx4RZGg6Q3dB
 1Vnp1QAlQdrPZL/GE/D9mtcg2SxfRnK2mCw517i3M3/WrVDWcdRmvtwkOIPZ0C4LiqOm2CqO6
 dp9X2SUF2BadVADTF784IgZuCpk7oT3dMka6f/jGH+6+NhPtGkSz1yOoOpHWaHUonA9TcmOIA
 GIs7rBHiq+nK9AKftOHT+wDS3aMihnK5cJhFtAcrd83vPQmAn0RNKpRqlReqfribx0QtGFWVC
 yZrCnVH1xG9wFyzFGwIKa0J0WUCVYVhCU57TpOB8D7pRcTvpZ3blWJf7IZMAV2uLe+emvlRXJ
 w+Q4hMKUDkTdPO9MWuUCZVD0G+BiB6ZEse54xGgskDwZG+gr9uXnpC/qyue5mSFnDXIzV6dmF
 xKz1joIiBO4ZnM5vkxzc1QIsge7nT+opkY8lH/xkcbVpRzK7ADQbExnSTisOqduBMbbzugE3g
 sDujw94MYII+cGWNTc9/jPFS+GnykVsZ33QWVvqn0flP92Fi63ZmMLEuZBpq76ZPCre1EMu9t
 mmiuylS3ITfTaF6n6SVnAUgO2jiFwzQJr9ZKPP5svuvuFep1sSOFAqCZhJwpm65vEqTPfWxTa
 DNyx5Vsw7SFEWp0FfGfco5ZKh0R+eiFrFi+vZb6mBKbtXzZI5gRtVSPrwUDElAeaIHoWJiD+L
 TozI9WnY8B3ORp93yX8EUdT4jpUlucC7tAXQ0ai508PnYuWKZ6zABLon3odkqWhzCjPuiwvNY
 qGRkEqd0DC5vpHW18gilEpor8uLDYCURh4IPPrzg3QexItllcukewepPInV3Mqh7HyrPQ=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

there is an issue with the Thunderbolt driver for the Ice Lake CPU
i7-1065G7 (used for example in the Dell XPS 7390 2-in-1) and Thunderbolt
docks (Dell WD19TB).

Randomly after anywhere between a few minutes and a few hours of use,
the Thunderbolt dock will have a "disconnect event" in which all
peripherals disconnect briefly and all external monitors flicker and
lose signal. USB Mass Storage connected to the dock suffer IO errors,
and the monitors briefly regain signal only to then lose it for good.
The dock must be reconnected or the system rebooted to fix it for a time.

dmesg may or may not show the following line when it happens:

[ 4552.598580] i915 0000:00:02.0: [drm] *ERROR* CPU pipe B FIFO underrun

The issue was reported by multiple users to intel-drm here:

https://gitlab.freedesktop.org/drm/intel/-/issues/1453

But it seems to be related to Thunderbolt, not the i915 driver, as
non-Thunderbolt external screens work fine, and the failure sometimes
affects everything attached to the Thunderbolt dock, not just the
monitors (dmesg then shows USB reconnects and "xHCI host controller not
responding, assume dead"). So I'm sending this to the PCI mailing list
to which all Thunderbolt issues are being redirected.

The laptop and dock work flawlessly under Windows (ruling out
hardware/memory faults), and the issue persists ever since the 5.4
kernel all the way up to the most recent 5.7.4.

If you need any more information let me know.

Regards
