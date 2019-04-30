Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94AE3101CD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 23:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfD3V17 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 17:27:59 -0400
Received: from ale.deltatee.com ([207.54.116.67]:41262 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfD3V17 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Apr 2019 17:27:59 -0400
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=[172.20.5.36])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hLaI8-00075l-Am; Tue, 30 Apr 2019 15:27:57 -0600
To:     Eric Pilmore <epilmore@gigaio.com>,
        linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
Cc:     Armen Baloyan <abaloyan@gigaio.com>, D Meyer <dmeyer@gigaio.com>,
        S Taylor <staylor@gigaio.com>
References: <CAOQPn8vMn4h=oGWWKa3Uge7WYMkmRAmTyhR6RPjGVtrR1hfhOQ@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4389bccb-6993-4a86-b4e4-202e971e2080@deltatee.com>
Date:   Tue, 30 Apr 2019 15:27:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOQPn8vMn4h=oGWWKa3Uge7WYMkmRAmTyhR6RPjGVtrR1hfhOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 173.228.226.134
X-SA-Exim-Rcpt-To: staylor@gigaio.com, dmeyer@gigaio.com, abaloyan@gigaio.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, epilmore@gigaio.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: NVMe peer2peer TLPs over NTB getting split
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-04-24 4:46 p.m., Eric Pilmore wrote:
> Hi Folks,
> 
> Does anybody know why a Host Bridge might break up a full-sized (max
> payload) TLP into single byte TLPs when those TLPs are traveling from
> peer-to-peer?

Host bridges can't be relied on to do the right thing with respect to
P2P. This is why the p2pdma code explicitly rejects them. Bad
performance is often the symptom and splitting may be the cause (I've
never bothered to stick an analyzer on it. There are patches floating
around to add a whitelist to p2pdma which would be what you'd want to do
and avoid anything that doesn't go through a switch.

Logan
