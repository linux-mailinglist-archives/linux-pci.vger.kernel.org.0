Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F171D0A57
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbfJII4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 04:56:21 -0400
Received: from foss.arm.com ([217.140.110.172]:57092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJII4U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 04:56:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F982337;
        Wed,  9 Oct 2019 01:56:20 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C897F3F68E;
        Wed,  9 Oct 2019 01:56:19 -0700 (PDT)
Date:   Wed, 9 Oct 2019 09:56:18 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     =?utf-8?B?5qGC5rC45p6X?= <opera.gui@fibocom.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: About PCIE MHI driver build question!
Message-ID: <20191009085617.GN42880@e119886-lin.cambridge.arm.com>
References: <HK0PR02MB3444E2FB30721FCADEE180FAEA950@HK0PR02MB3444.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK0PR02MB3444E2FB30721FCADEE180FAEA950@HK0PR02MB3444.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 09, 2019 at 06:51:25AM +0000, 桂永林 wrote:
> Hi,
>    I had got a Qualcomm MHI PCIE driver which had released on kernel_xiaomi_sm8150/drivers/bus/mhi/ path. But I can't build the driver and the kernel. If someone can help me give me a guide about how to build the MHI driver?
>    I use bellow command to clone the project:
>       git clone -b https://github.com/Demon000/kernel_xiaomi_sm8150/tree/lineage-17.0
>    The MHI driver located at kernel_xiaomi_sm8150/drivers/bus/mhi/ path.
> Thanks!
> Opera
> 

Hi Opera,

Unfortunately that Github URL relates to a fork of an earlier mainline kernel,
the driver you refer to was added in that fork and not the mainline kernel. So
it's unlikely anyone here will know anything about it. I'd recommend you find
out who added that driver or who can provide support for that Github fork.

The mainline kernel does appear to have support for PCI for the SM8150-mtp,
see if arch/arm64/boot/dts/qcom/sm8150-mtp.dts fits your needs.

Thanks,

Andrew Murray

> 
> 
> 
> -----邮件原件-----
> 发件人: gregkh@linuxfoundation.org [mailto:gregkh@linuxfoundation.org] 
> 发送时间: 2019年10月9日 14:40
> 收件人: 桂永林 <opera.gui@fibocom.com>
> 主题: Re: 答复: About MHI driver build question!
> 
> Hi,
> 
> This is the friendly email-bot of Greg Kroah-Hartman's inbox.  I've detected that you have sent him a direct question that might be better sent to a public mailing list which is much faster in responding to questions than Greg normally is.
> 
> Please try asking one of the following mailing lists for your questions:
> 
>   For udev and hotplug related questions, please ask on the
>   linux-hotplug@vger.kernel.org mailing list
> 
>   For USB related questions, please ask on the linux-usb@vger.kernel.org
>   mailing list
> 
>   For PCI related questions, please ask on the
>   linux-pci@vger.kernel.org or linux-kernel@vger.kernel.org mailing
>   lists
> 
>   For serial and tty related questions, please ask on the
>   linux-serial@vger.kernel.org mailing list.
> 
>   For staging tree related questions, please ask on the
>   devel@linuxdriverproject.org mailing list.
> 
>   For general kernel related questions, please ask on the
>   kernelnewbies@nl.linux.org or linux-kernel@vger.kernel.org mailing
>   lists, depending on the type of question.  More basic, beginner
>   questions are better asked on the kernelnewbies list, after reading
>   the wiki at www.kernelnewbies.org.
> 
>   For Linux stable and longterm kernel release questions or patches to
>   be included in the stable or longterm kernel trees, please email
>   stable@vger.kernel.org and Cc: the linux-kernel@vger.kernel.org
>   mailing list so all of the stable kernel developers can be notified.
>   Also please read Documentation/process/stable-kernel-rules.rst in the
>   Linux kernel tree for the proper procedure to get patches accepted
>   into the stable or longterm kernel releases.
> 
> If you really want to ask Greg the question, please read the following two links as to why emailing a single person directly is usually not a good thing, and causes extra work on a single person:
> 	http://www.arm.linux.org.uk/news/?newsitem=11
> 	http://www.eyrie.org/~eagle/faqs/questions.html
> 
> After reading those messages, and you still feel that you want to email Greg instead of posting on a mailing list, then resend your message within 24 hours and it will go through to him.  But be forewarned, his email inbox currently looks like:
> 	912 messages in /home/greg/mail/INBOX/
> so it might be a while before he gets to the message.
> 
> Thank you for your understanding.
> 
> The email triggering this response has been automatically discarded.
> 
> thanks,
> 
> greg k-h's email bot
