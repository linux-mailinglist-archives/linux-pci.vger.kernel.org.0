Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A61447357
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 15:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhKGOnr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 09:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhKGOnq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 09:43:46 -0500
Received: from bedivere.hansenpartnership.com (unknown [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B63C061570;
        Sun,  7 Nov 2021 06:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1636296047;
        bh=GLwJRm0SyCJdBFI1kf9KhZvQdd89cg3gLgrxFC+Qp7s=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=K9s/EzIMwWN6NMlTLphqEw1AACL2pK+z7aShJ8CsrSvAofK8EPh+sDe7qNdeu/gn6
         7yaYMHSFTsL/F57EAKYIQAs/MWQMs9Y4HsOsiqOhgLc7H2N9neqOJnaqL/7NYLStYU
         70hXC7i4D9Xd2oTWohABAdtCjdtwFQCPvGKYZcDE=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8D93012807C9;
        Sun,  7 Nov 2021 09:40:47 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WJe4HCRbb8uE; Sun,  7 Nov 2021 09:40:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1636296047;
        bh=GLwJRm0SyCJdBFI1kf9KhZvQdd89cg3gLgrxFC+Qp7s=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=K9s/EzIMwWN6NMlTLphqEw1AACL2pK+z7aShJ8CsrSvAofK8EPh+sDe7qNdeu/gn6
         7yaYMHSFTsL/F57EAKYIQAs/MWQMs9Y4HsOsiqOhgLc7H2N9neqOJnaqL/7NYLStYU
         70hXC7i4D9Xd2oTWohABAdtCjdtwFQCPvGKYZcDE=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2B8EA128078F;
        Sun,  7 Nov 2021 09:40:46 -0500 (EST)
Message-ID: <7097cb64691e3059962343dd4f10a7a50b54f704.camel@HansenPartnership.com>
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        stuart hayes <stuart.w.hayes@gmail.com>
Cc:     "Tkaczyk, Mariusz" <mariusz.tkaczyk@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "lukas@wunner.de" <lukas@wunner.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Sun, 07 Nov 2021 09:40:40 -0500
In-Reply-To: <CAPcyv4j_HH+T+Bnhqk_iV-JpemB6D=mXjk14cGMJMitkxrbjJQ@mail.gmail.com>
References: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
         <5d1eb958c13553d70e4bee7a7b342febcf1c02ee.camel@intel.com>
         <4bb26dc0-9b82-21d6-0257-d50ec206a130@gmail.com>
         <CAPcyv4iig5rxCNb7GyGV9akhZKLF+OeGhewSbOeAzzA6pKreRA@mail.gmail.com>
         <19dcfbea-efcd-b385-4031-23fae5c1c78b@linux.intel.com>
         <4cb4d599-a146-2219-6c6a-c713f022bd7c@gmail.com>
         <CAPcyv4j_HH+T+Bnhqk_iV-JpemB6D=mXjk14cGMJMitkxrbjJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2021-11-05 at 19:52 -0700, Dan Williams wrote:
> [ add James and Martin in case they see anything here that collides
> with the SES driver ]

It's a bit difficult to tell among all the quoting.  However, I will
say that if you want to play with drivers/misc/enclosure.c you need at
least to cc the maintainer and preferably linux-scsi because they're
currently the only consumer ... and the enterprise does a lot with ses.

James


