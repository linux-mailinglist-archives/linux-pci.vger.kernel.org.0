Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9CD2AFAE1
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 22:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgKKVzu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 16:55:50 -0500
Received: from www84.your-server.de ([213.133.104.84]:44702 "EHLO
        www84.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKKVzu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 16:55:50 -0500
X-Greylist: delayed 1218 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2020 16:55:49 EST
Received: from ipbcc25655.dynamic.kabel-deutschland.de ([188.194.86.85] helo=[192.168.0.7])
        by www84.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <stefani@seibold.net>)
        id 1kcxlq-0001Hv-6S; Wed, 11 Nov 2020 22:35:14 +0100
Message-ID: <76e195ae936730af4d8abc2e597dd8a011bf0138.camel@seibold.net>
Subject: Re: pci_alloc_irq_vectors fails ENOSPC for XPS 13 9310
From:   Stefani Seibold <stefani@seibold.net>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Thomas Krause <thomaskrause@posteo.de>
Cc:     Govind Singh <govinds@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-wireless@vger.kernel.org, Devin Bayer <dev@doubly.so>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ath11k@lists.infradead.org, David Woodhouse <dwmw@amazon.co.uk>,
        wink@technolu.st
Date:   Wed, 11 Nov 2020 22:35:10 +0100
In-Reply-To: <87imab4slq.fsf@codeaurora.org>
References: <20201103160838.GA246433@bjorn-Precision-5520>
         <874km61732.fsf@nanos.tec.linutronix.de>
         <fa26ac8b-ed48-7ea3-c21b-b133532716b8@posteo.de>
         <87mtzxkus5.fsf@nanos.tec.linutronix.de> <87wnz0hr9k.fsf@codeaurora.org>
         <87ft5hehlb.fsf@codeaurora.org>
         <6b60c8f1-ec37-d601-92c2-97a485b73431@posteo.de>
         <87v9ec9rk3.fsf@codeaurora.org> <87imab4slq.fsf@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: stefani@seibold.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25985/Wed Nov 11 14:18:01 2020)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2020-11-11 at 21:10 +0200, Kalle Valo wrote:
> 
> 
> The proof of concept patch for v5.10-rc2 is here:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/1605121102-14352-1-git-send-email-kvalo@codeaurora.org/
> 
> Hopefully it makes it possible to boot the firmware now. But this is
> a
> quick hack and most likely buggy, so keep your expectations low :)
> 
> In case there are these warnings during firmware initialisation:
> 
> ath11k_pci 0000:05:00.0: qmi failed memory request, err = -110
> ath11k_pci 0000:05:00.0: qmi failed to respond fw mem req:-110
> 
> Try reverting this commit:
> 
> 7fef431be9c9 mm/page_alloc: place pages to tail in
> __free_pages_core()
> 
> That's another issue which is debugged here:
> 
> http://lists.infradead.org/pipermail/ath11k/2020-November/000550.html
> 

Success on DELL XPS13 910. Applying the patch and revert patch
7fef431be9c9 worked for me.

Thanks!


