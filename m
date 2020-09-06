Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CC625EF7C
	for <lists+linux-pci@lfdr.de>; Sun,  6 Sep 2020 20:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgIFS1Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Sep 2020 14:27:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:59137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728969AbgIFS1N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Sep 2020 14:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599416804;
        bh=2Ppyix6Y9pVqwAOomMgrqfY0I+MRBSmelBiqaDpZmwM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:Reply-To:From:Date:
         In-Reply-To;
        b=KBLRcTLJOt8YinkXmAmvSvtSwK7m96mWN+HQ99a2lGlgh7sl/knXD53R0I+w1+fG3
         7w/lh+VKG7iJQdcW8lMe4FALXDVJBjwAnDtu6dGbl6LT8otJPODgUiF+oBp5U7VbZs
         KZrnxa5ijfSyEFVaYB1GipVu5LyZQxS1C5iEXVsc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mandree.no-ip.org ([84.160.55.91]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTRH-1jrhjN2t6L-00NTgm; Sun, 06
 Sep 2020 20:26:44 +0200
Received: from ryzen.an3e.de (localhost [IPv6:::1])
        by ryzen.an3e.de (Postfix) with ESMTP id BA277120106;
        Sun,  6 Sep 2020 20:26:41 +0200 (CEST)
Subject: Re: pcieport 0000:00:01.0: PME: Spurious native interrupt (nvidia
 with nouveau and thunderbolt on thinkpad P73)
To:     Marc MERLIN <marc_nouveau@merlins.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, nouveau@lists.freedesktop.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191004123947.11087-1-mika.westerberg@linux.intel.com>
 <20191004123947.11087-2-mika.westerberg@linux.intel.com>
 <20200808202202.GA12007@merlins.org> <20200906181852.GC13955@merlins.org>
Reply-To: invalid@invalid.invalid
From:   Matthias Andree <matthias.andree@gmx.de>
Message-ID: <83a84ca8-1f61-962e-4329-1a5e85e64dab@gmx.de>
Date:   Sun, 6 Sep 2020 20:26:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200906181852.GC13955@merlins.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:pcuxN8MATZXEDYk6XIomOMPYxsUCRK4B4jiQ41qoH+xG0lXn4ZH
 beUhbkTTeVPibDBDU1POsQ4BIHkExSNLupSujeqSLV+24mCfKR59v8NlECuvWVB5vfeC6vB
 bINs6tqv5euXY/GkuDumkC9fSnGS/Vq84drPmqWpbYt0obQyU4KGm05xVx4Xu2yLHIPNwcc
 s91m0gaSJBD4gO44U0lgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q0j6mXjJslo=:XzbW+8WyG6CvL0hx+bMKNF
 hTogB5PUcfv4RidxWHk+a4q3F8Xru3lQUK8W9bPPcvdkUoG3XTSJoo82YA013NfqI3il1NaYX
 APcGGJFIsfi6+RaxNxAFeDY/r8kk1Yes3uUx/pj67RbRGTm0VJvYD6RqW0jvV56PWLLl9bh6E
 8U1qhKoAHBpmg06SksR/tfIZTNAOyfKw13SaeSVhYYH/cRaRWfOAKANJyaenzCyVvZ2M9KFRn
 /ABxCIN6aUN++Wonj32tdVI0LKx/IcJWtUJ+MrV4lRowdaK1SxFWdevKN9Q6CHNvjVkqOQGaa
 1TC0kKXLn/r3AngUTUeOT0BjU+Y3YpXYzobaGEcGcfvlDZP6N7YYbi8noHRuN5nRTAePBpseB
 MEKvr844jiaxqce9KFDP0XP6JVzMQbrOyfAdG9oTrSuf0tZj4Pue4/6YH62bmmaVnpNkzi9cJ
 d6Ksb0ESZiwbNFH0+VuP3/o+ckFe7idAN4UzNbBl0pNzF0yZ2HcQcxoIshNipj8Oy2mZRJ9be
 jQMDB1fBuTMIpNxpXNLSGXKywQYbKKemu6Pn9CtT9z3jmqAE2sBBJywsZfONIj9mPpVTpNCC0
 1fPgZSzPVvAXBkRkmogBlvfFPmAxWW/VmGO5qd3bNyjNPG0BYfMZ5CODLfzth5bnryLSa9KS0
 9YBXLSbtdqStF39RxFWYokvtVfHCatkJIUaN27WNOySpV4noA/oMiGo72jZhcuhZQHMYJ122H
 fwbqJQQg9ih3zVUUX80GoU8/y0Q5hCIve4+ebVc4rc2ycdsPxh3Bpjd+vSPUOw8/T+lCtSaoc
 ZFr2KsQD3xrQzAdHhEIl5d7NWcgiLiLr3D6drVg4fEVjBGydzd8NCJYB6ZDZ+aJm+HGvByitN
 BVzQbRIu9Jjrg/6famV0oqEAgQNW3kxzOLF61xKacFZIdBuqjjvmyY0Ov3qE3Cuqa63hcq8WN
 GjxDD7zXY+EVYNmvb3EHiBpMFEgwfl3uojZlyjeHT26LJ0aqmlInzsi3ck3juOrtTr4ETunzu
 Ejgpyt2q6ro6IbYYl4m6eB6B8tEi/8i5c55qtLSrItVZVN90EFFnCseU8/7r9M3b85yrMKKmB
 9yNUcV1wKyWyYYE6/nWp9FsJsoemhgn47WnMox3MalF0xrJkAYJhfb9SH4ohj5/tCq1rkZ1Xm
 6Fvm5sk+/F28FmBKrCnay6rnI7ghdO3gzOyKq5VIu7tauxDy9pWi83FiY5py0+7lv7NI6Q814
 O91zqWQI6RK9GOwffMEARtex5lTuxCzLp0Ci/5g==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please everyone stop Cc:ing me on this discussion, I have no interest
and nothing to contribute here.

I have set an invalid Reply-To: just in case...


