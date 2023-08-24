Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88902786847
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 09:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjHXH2a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 24 Aug 2023 03:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240223AbjHXH2V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 03:28:21 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Aug 2023 00:28:16 PDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8626C10C8;
        Thu, 24 Aug 2023 00:28:16 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,195,1684771200"; 
   d="scan'208";a="63385427"
From:   <huangshaobo3@xiaomi.com>
To:     <tglx@linutronix.de>
CC:     <bhelgaas@google.com>, <chenwei29@xiaomi.com>,
        <darwi@linutronix.de>, <huangshaobo3@xiaomi.com>, <jgg@ziepe.ca>,
        <kevin.tian@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <weipengliang@xiaomi.com>,
        <wengjinfei@xiaomi.com>
Subject: Re: Subject: [PATCH] pci/msi: remove redundant calculation in msi_setup_msi_desc
Date:   Thu, 24 Aug 2023 00:27:12 -0700
Message-ID: <1692862032-37839-1-git-send-email-huangshaobo3@xiaomi.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <87bkexetfk.ffs@tglx>
References: <87bkexetfk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.237.8.22]
X-ClientProxiedBy: BJ-MBX16.mioffice.cn (10.237.8.136) To BJ-MBX01.mioffice.cn
 (10.237.8.121)
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_SOFTFAIL,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 23 Aug 2023 16:15:27 +0200, Thomas Gleixner wrote:
> On Fri, Aug 18 2023 at 07:26, 黄少波 wrote:

> Your patch is corrupt:

>  Applying: Subject: [PATCH] pci/msi: remove redundant calculation in msi_setup_msi_desc
>  error: corrupt patch at line 12

> It's DOS mangled and whitespace damaged.

Very sorry, may have accidentally broken the patch format,
and will make sure to use plain text next time.

> > Whether to support 64-bit address status has been calculated before,
> > and the calculation result can be used directly afterwards, so use
> > msi_attrib.is_64 to avoid double calculation.

> I'm not seeing what this solves:

> > -       if (control & PCI_MSI_FLAGS_64BIT)
> > +       if (desc.pci.msi_attrib.is_64)

> Both variants resolve to a test of a bit and a conditional instruction
> on the result. It's exactly zero difference in terms of "calculation".

> So all this does is change the memory location to test. Not more not
> less. It does not generate better code and does not save anything.

It may not be appropriate to write to eliminate duplicate calculations,
can it be proposed again with clean code?

> Thanks,

>         tglx

thanks,
sparkhuang
#/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
