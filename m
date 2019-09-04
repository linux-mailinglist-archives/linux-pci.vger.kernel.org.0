Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B37A8BD8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 21:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbfIDQGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 12:06:42 -0400
Received: from smtp122.ord1c.emailsrvr.com ([108.166.43.122]:46646 "EHLO
        smtp122.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731900AbfIDQGm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 12:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1567612789;
        bh=Kva2ujk4tlH3H9vBbavWY5VkbDF1WFrWyZNost4mZxI=;
        h=To:From:Subject:Date:From;
        b=c6QDhRp9jDiVwe+WUiRmdN4+BdPIkSMfbId8/D/8VrQ8sN3JAVtVLeOnrI1PSzLvv
         MQdQHAVJYQdzY+4+bpMlDgHMjFAAZ21T1TXjDwPSE0ZkliupznSKQr3FzwIlWVCJRq
         RZg+/JA7p4EdffLKiz/2iHyNuvoEOb4UEHnl1T2Y=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp24.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 0869E60326;
        Wed,  4 Sep 2019 11:59:48 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 04 Sep 2019 11:59:49 -0400
To:     linux-security-module@vger.kernel.org
Cc:     linux-pci@vger.kernel.org
From:   Ian Abbott <abbotti@mev.co.uk>
Subject: Should PCI "new_id" support be disabled when kernel is locked down?
Organization: MEV Ltd.
Message-ID: <cf90a8aa-536e-f4df-0b2f-60724e4034fb@mev.co.uk>
Date:   Wed, 4 Sep 2019 16:59:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

The "new_id" PCI driver sysfs attribute can be used to make an arbitrary 
PCI driver match an arbitrary PCI vendor/device ID.  That could easily 
crash the kernel or at least make it do weird things if used 
inappropriately.  Is this scenario in scope for the "lockdown" security 
module?

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
