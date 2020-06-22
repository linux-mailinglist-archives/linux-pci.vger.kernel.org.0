Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AC32030AE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 09:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbgFVHep (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 03:34:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:57477 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731323AbgFVHep (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 03:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592811282;
        bh=+Ip11REy4BHUqrKIldsyQ0hoMMg0MGPJin6EmDd5heM=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=JmtCdu4472s8M03V2Iaz/SXhoxMNe+4TbnF9GnJSpt9OkgO9bsFx1cMcNc3frosME
         ydL92yTH7PDmIHNx9/RZXLHKDjXd9dXlfIWy+y7PEmqY54pBwihtfKoVZ6NdSf3jmm
         V0xBc5SZJ3BA4DHmSm55DcbUyFJ+3buLK6RiKyWs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.11] ([84.114.190.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysW2-1isg0e12ig-00vtmW for
 <linux-pci@vger.kernel.org>; Mon, 22 Jun 2020 09:34:42 +0200
To:     linux-pci@vger.kernel.org
From:   grinko <grinko@gmx.at>
Subject: Ice Lake i7-1065G7 and Dell WD19TB TB dock: disconnect failures
Autocrypt: addr=grinko@gmx.at; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b01210dc-f0b9-d8a6-a01d-a15bd1dfa29e@gmx.at>
Date:   Mon, 22 Jun 2020 09:34:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:I3pG+tnaMssK1TIGko4MBnsDvYNR72qD0Mc+e7cmSqrDxn6DGS7
 ykKR5cOr9LAgYsQomot5afDTChdTmARX4Mq1iCrAiGeOCWOJEl2ozJpfOXN/W29OYVKzXMw
 m2DiC/3BRxrh//oAM70JZGQjKjK6Xdgbbvo6CDMNwJnoiZXOs8SG1KGtLM7JKB/d4XegTsX
 usKbmj+S0c2Xf8jwL09nQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0QVEBEJ2DXA=:IXOaCRitk35zpZHnw7Hf0L
 IjaEey4PTCPAl3gJ6DlS0pX+l9T8j2GWMsEOSFNF0MiVGdFfwmoMyBtSF5jWbxD3G9ReGQzeU
 r4Bw6z5AmTsTWh6BFo+bruLlPLASq+ROs5X2G6fpQuKkjJScl4V8F4+ByzM8YsiPucGraPnrH
 r1EuD3AJhlwu8fH+0wH/CRd8ed7+wD7TsKqkTr3SYLTR1WRtJLWkpNSOpN8c4E/b7wtxm8bHr
 nwUoGZQdH2VCsuylWWP/34LFGbmhJNxAgJRX6t8t/6r9WZMxFds7CYy+wyVMPYc/RleZNGlcB
 ZdImsDI4rDjfPz04LnIgB1U57+aNc3/TL8mTJ53mPQ4Xpqmm5vrjHK3b7Q6WfROA44P+4FVjl
 gKikfbTJyBa8LjbwozgNb64BxM0DEk/0xVrv577R/iAnXS1XPMyPf3diNiKUyi55tbpVjvQor
 Df86Xon4tW+KZfigiTP/cwLGMikenbjnOOiR/+ssG5HTBeu98DKVnCWMb7GfJpRvaopCV/KOD
 tTUyIanmfO9a+YYp4ggp4zW8fipBf3HXGe+Fd2wD5Z2deixUQ5t6/ooKpkb0I3sFZhEqFnUNr
 1iVhDxtx/urmm1Wp4W4CbUlAcJvNFUoXnnoMLnombqkSUDgAJIs/5IpyAM97QNsze99X8O1gp
 G4KA3qDaajnpxV54dgiiqHGFkVECMqoMttjfW9v72kPMgiGuN+4JDxJaJOnsOy9BG74bXEB+/
 yohi+c5GnWGVfbgIq4X3J5zXF6eKlSvjUhfxZYeFsvJQGGMUcseiQ5tn5iyA45oIrXyPXY6pD
 ACKp0VBd+Gj22nqd7PUH+csKRLNt/+/pTagXC7Zdsfvb0EGghCBB557fHieuJpcfadFw4WYiK
 TuoBJ6fMVVMCKgwmnUR9lsJpHVJAjC19ss8MljnypVVnIgTCtdybmujH5cWgxL6dzgu2ia/Om
 E6Dsky+MEKZdFqwF9Rtah39GqWlIpl7x+CbmdUkkYmitnF0nQAWBlzsCy8ZVv07g4OIOgCzqQ
 0Nmx7m6mnTBwKIRZHysUALl8vXxggMiZuRj9aN0V25JA+CS4fdpliu64b8YvdLFv5cW8W1W66
 OrdPDV3Irgaa7H6Aod0hX6rWbkPmjHHKcY6G7lGJjqbXSu4wGG/jVh5HoVQzg2Dm/fyiv+57s
 KrFsx6MEk0gEhKQ4Mb6Z8jiMG3MyIK8e3fLQkmMy43ZjcjOD23WjRwyhlATfIXA2GRWB0=
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
