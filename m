Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780BD44B014
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 16:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhKIPNX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 10:13:23 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:28071 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhKIPNW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 10:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1636470615;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=qo23Dfgejx+fYTtjOXsLmDvjS1BIif2nHt5BFMBXLXU=;
    b=czoIGDT9EWkuNsFYjeB0wx/bZDy8B26ZiWnI/zY0xc6PP85zs0G30CetBaYYCSpVKf
    MwdVFoZ5fw3QCzi7y/kxPrxwztJXV22clvfSpTpG/phavp5vAS3tRtlTWK4TWv/N9TaE
    dgHKvQ1xOXXy6DGS9vVEWsgG/bQ9mk4pu78H4fJrFZyduIVjWOg3XdVKc+tuyFfjTMqV
    hVVnna6KnFAsf4iJHSIflqP5wftkaMqVS+/kRwE7XDE11wp95Fu4vXwyY6SjlA3THPP3
    kknmnyK3c1EHDVfNPA1TcWUqBBexd8P6Fw5lKT9PPbf8mkYVd4su+jYSL9StAZqkznTQ
    KDAQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBJSrwuuqxvPgCcvDwpSXvD4psVrwPNFokQjBO3A=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a02:8109:89c0:ebfc:ad8c:b313:ee31:b71d]
    by smtp.strato.de (RZmta 47.34.1 AUTH)
    with ESMTPSA id w0066dxA9FAEqB3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 9 Nov 2021 16:10:14 +0100 (CET)
Message-ID: <ee3884db-da17-39e3-4010-bcc8f878e2f6@xenosoft.de>
Date:   Tue, 9 Nov 2021 16:10:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
Content-Language: de-DE
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
To:     "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Olof Johansson <olof@lixom.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     Darren Stevens <darren@stevens-zone.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        mad skateman <madskateman@gmail.com>,
        Matthew Leaman <matthew@a-eon.biz>,
        Christian Zigotzky <info@xenosoft.de>
References: <3eedbe78-1fbd-4763-a7f3-ac5665e76a4a@xenosoft.de>
 <15731ad7-83ff-c7ef-e4a1-8b11814572c2@xenosoft.de>
 <17e37b22-5839-0e3a-0dbf-9c676adb0dec@xenosoft.de>
 <3b210c92-4be6-ce49-7512-bb194475eeab@xenosoft.de>
In-Reply-To: <3b210c92-4be6-ce49-7512-bb194475eeab@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09 November 2021 at 03:45 pm, Christian Zigotzky wrote:
 > Hello,
 >
 > The Nemo board [1] doesn't recognize any ATA disks with the pci-v5.16 
updates [2].
 >
 > Error messages:
 >
 > ata4.00: gc timeout cmd 0xec
 > ata4.00: failed to IDENTIFY (I/O error, error_mask=0x4)
 > ata1.00: gc timeout cmd 0xec
 > ata1.00: failed to IDENTIFY (I/O error, error_mask=0x4)
 > ata3.00: gc timeout cmd 0xec
 > ata3.00: failed to IDENTIFY (I/O error, error_mask=0x4)
 >
 > I was able to revert the new pci-v5.16 updates [2]. After a new 
compiling, the kernel recognize all ATA disks correctly.
 >
 > Could you please check the pci-v5.16 updates [2]?
 >
 > Please find attached the kernel config.
 >
 > Thanks,
 > Christian
 >
 > [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
 > [2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4 


+ Olof Johansson
+ linux-pci@vger.kernel.org
