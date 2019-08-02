Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1A68009F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfHBTDT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Aug 2019 15:03:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:35665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbfHBTDT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Aug 2019 15:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564772588;
        bh=y5R4yNqB38RdL34MfbHQ8UGfJriemm8jwOoEstt33Ss=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=YTwVbqVu3W18yIKo2VTlLGasrFQNUDELBkaB8ZpU0Xt/quvwg+fhxUtnHS6/YGjWm
         n4+j5/0Bpv8up2ycE2AKcNOJl7miPeMlgEWlRRW25eRzgN2Ip3K+FxEFUata9oxwA5
         8pDd+JyrPZfT75xxZ3yakyw7TybYdMV1Ynqb25/M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mandree.no-ip.org ([79.229.32.156]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1jKo-1iDtji237S-00tjI3; Fri, 02
 Aug 2019 21:03:08 +0200
Received: from ryzen.an3e.de (localhost [IPv6:::1])
        by ryzen.an3e.de (Postfix) with ESMTP id 236F412050F;
        Fri,  2 Aug 2019 21:03:07 +0200 (CEST)
From:   Matthias Andree <matthias.andree@gmx.de>
To:     linux-pci@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.andree@gmx.de; prefer-encrypt=mutual; keydata=
 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
 H29L93g/7fa+B3v7
Subject: regression: PCIe resume from suspend stalls I/O and causes interrupt
 storms in Linux 5.3-rc2 (5.2.5, 5.1.20) on Ryzen 7 1700/AMD X370 MSI board
 since 5817d78eba34f6c86f5462ae2c5212f80a013357, 5.2/5.3 w/ pcieIRQ loop.
Message-ID: <935c6fd8-c606-836a-9e59-772b9111d5d6@gmx.de>
Date:   Fri, 2 Aug 2019 21:03:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:cwFGBqs95WwQBavdk7whRvmHSEFoQQXwc6g+M7baDac0/fJGvWe
 byRx6yQoYvaPjf4pcdSIQk/yZ+2kUyn9g8O5IMMVNAzyGe6p7jBnlN4pwYPQB13am0VbL3e
 YMKbnXrP8lWPHSzp30UOc7SUCVyWIhkNCgLvNmETUZP0QhVOpYMAKpF/71qK0FZl8XnLtxI
 EV4tW9Jiaj18rYYW2iI3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+ffJt1Wo24Y=:RKIaLqBwI5dlR8bugWG703
 pTrjvu1ihrsGq3OhpYgUD0JNalTnGLlbblsspkcRLMvSN8pEBvmq00nTpASirP9KJCk+eIFHW
 xWTYCnASAVFAWyOa+9LnMHI1xZZ+Uty9BacHypKlzm3fcfe2zrQL1xT8i74zIe5y0CY6P8Al7
 ozmW6zX2dn1cw/APchPjqmHIuAgrH2n6pfU0IwT4MAbIee9bN3Ge3OcUEUbPe5Os2KKDtmNZ0
 F7llsPE28mfHsu4mcAUEaJSO4t6DKvLWKqRpegkoedUCpGzV8157IVr1HWAP4wo8zwPLfOd+V
 X5z67qUKLhrwfnxd17L9UQYNtBG6jGDBXpx/wjaAxlFUrGdkXgY98jI44rStwQaDGUyHH8i2D
 l9Uvh29rgUqeDDtjqRfy5pQdOle6j2IdQUBf5wJZO5fpCneIwoUy9WacaS/gXv77RS4y2D8/0
 spLUpHqa3txENjxRFhlQEY35nATWFi+lLj6UHYqnddFAskIG26jBiRGt2Hu91dyqJm0kDJAa5
 ok36RAcY3/5FIisOW049BvF1VqucR+JcbOFBTNhhFPiCW7Kp6YUBk3majZzxW0Ac9y5If1P4c
 gmr/Xns3oDtTWREfm7zCrRDnVymG8Bu3h13A/g+W95ShT+9cntR/OlftKEABBtf6OOALMO2Zo
 ml3CGD2qozUoPqfNUwVZCQT9CS/XSYgbYxotrMht2gbzXbF+2vhRoz/D/jkNQ2KMoDoySt0MU
 eXjcPTX6HU4gtkPK8Yu+zrrqnXUdmXkVnD2wDCiwKFYX0vLOzrsRGpDLdNPaTuHMHT+B7qVZz
 qEWAke3mbs9gZshpgitVmGmk/7NNSqGmWYRbrCG8iq03fU/OErQUuKyC4YMge+q4F49MyKvTY
 7tRoNgmbYLhPQurWxLQFrVxLSdI0t87neW4cRkA7DOcg0ZvVyveZ8N0REGvv6WTqi3juxkDMD
 2SYzKLj06gmJHm5tENoGTDqc76czMGQoY3hjYJLoUZ/wVjsIpWGIiyWo7USV9aPo5F1oAJaXj
 LLU2yCS+HTfuPpgtxJFgfl6oz7wJ1UfBMOSn+XID3dHfhY2Ua+Q1zEzRVYGAJmC6Hl85PcnK4
 o4mO6ZX5ZaGR7xm0oMhre50gYAvFe+zq8kcesfeV/7CHi5l1YBjDkSOJfHF4h38NZGgvAIIvj
 sOGHs=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greetings,=C2=A0

Commit 5817d78eba34f6c86f5462ae2c5212f80a013357 (written by Mika
Westerberg) causes regressions on resume from S3 suspend on my MSI X370
w/ Ryzen 7 1700, which is, TTBOMK, a PCI Express 3.0 platform.
Consequences are hung disk and net I/O although re-login to GNOME works
on 5.1.20, albeit very slowly. The machine is unusable after resume from
that point.

5.2.5 and 5.3-rc2 will go into a tight loop of pcieport 0000:00:01.3:
PME: Spurious native interrupt! and need to be rebooted.

bad: v5.3-rc2

good: v5.3-rc2-111-g97b00aff2c45 + "git revert 5817d78eba"

Reverting that commit shown above restores suspend functionality for me,
two S3 suspend/resume cycles work.

For details, more information (lspci, versions found) is at:

* Kernel Bugzilla, https://bugzilla.kernel.org/show_bug.cgi?id=3D204413

* Fedora/Redhat Bugzilla,
https://bugzilla.redhat.com/show_bug.cgi?id=3D1737046


Same findings for v5.2.5 on stable kernel, reverting the relevant commit
(SHA is 5817d78eba34f6c86f5462ae2c5212f80a013357 there) also fixes
suspend/resume problems for me.

Let me know if you need me to pull out any further hardware or kernel
debug info, but please be specific with instructions - I am not a kernel
hacker (although I have been exposed to C for nearly 30 years and
Linux/FreeBSD for some 20 years). Pointing me to relevant URLs with
debug instructions is fine. I have a Git tree handy and this octocore
sitting here compiles a kernel in < 10 minutes.

Regards,

Matthias


