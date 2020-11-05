Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBD42A8A52
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 00:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbgKEXAo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 18:00:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59654 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731860AbgKEXAn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 18:00:43 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604617241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tz7m6BIOMuQlyFY37lHCaVeHt6JeUnmsr+dDR5lFJn8=;
        b=gHeFlHOna6JrJgqSnxi/s5nT3Ju0xpCJK5lZ3BFoV3zddqdHkEibo1fav4UT1JDXNvUoyC
        Dca6+/Zp5erjKWLsZluVuHgkmRnBwvRinNTIh75zMlDWAOLFwlD/kcIIgt80g9ka7+1c0Q
        GdJH1yVXGBBSC8fdUMockqHuwoXJEAMCS9uEOzUoJaK6hJmYT5tmbKuGWvQwu8vglLffTD
        OQrTGEo+urMvkUqkKQr+fGVPEcuPgw3pP7ZT2wu29emTNyBdzFcDqpT+ottxtAd+4UGFee
        lNEbNzUAWxq1cH5hDrPD7i/v433TAPCuxZdAUJctj5xxb60aIlR4r+/f03y3Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604617241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tz7m6BIOMuQlyFY37lHCaVeHt6JeUnmsr+dDR5lFJn8=;
        b=TfHby8VV4W1CChr0voWomcazL5DKNae6yYtIu+oRcJgKYQzAhuxGqoH9/N1QOdYkbu0L+8
        Yl++Nidf+A30u1Cw==
To:     Marc Zyngier <maz@kernel.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re:  Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <074d057910c3e834f4bd58821e8583b1@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de> <878sbm9icl.fsf@nanos.tec.linutronix.de> <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de> <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22> <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08> <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de> <df5565a2f1e821041c7c531ad52a3344@kernel.org> <87h7q791j8.fsf@nanos.tec.linutronix.de> <877dr38kt8.fsf@nanos.tec.linutronix.de> <901c5eb8bbaa3fe53ddc8f65917e48ef@kernel.org> <87o8ke7njb.fsf@nanos.tec.linutronix.de> <trinity-1d7f8900-10db-40c0-a0aa-47bb99ed84cd-1604508571909@3c-app-gmx-bs02> <87h7q4lnoz.fsf@nanos.tec.linutronix.de> <074d057910c3e834f4bd58821e8583b1@kernel.org>
Date:   Fri, 06 Nov 2020 00:00:40 +0100
Message-ID: <87blgbl887.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 05 2020 at 09:20, Marc Zyngier wrote:
> On 2020-11-04 23:14, Thomas Gleixner wrote:
>>  	/* Resource alignment requirements */
>>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>
> If that's the direction of travel, we also need something like this
> for configuration where the host bridge relies on an external MSI block
> that uses MSI domains (boot-tested in a GICv3 guest).

Some more context would be helpful. Brain fails to decode the logic
here.

