Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA67622328
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 05:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiKIEgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 23:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIEgY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 23:36:24 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924231A81C;
        Tue,  8 Nov 2022 20:36:23 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b185so15634659pfb.9;
        Tue, 08 Nov 2022 20:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aEDK+MD7msFVnEXL1lXahPug1mTti/EdfAzUWZkIleA=;
        b=Bu+6eVths6VcWok9lTkW91272j4CFzQsqJGBHJzOCpTGF3yvLoHVuG/MzxPrgDSe3U
         IjBWbs9IYXjBEGQ8op46MbqJD/B1uvMf5y7gmUCkke6nfAWEJvHbCHIYSBHldUyPwgZr
         8i3KhsXw4nWiRV2jrEB9KTWErEPxfGhGnTF4jVJkevRS4peXDPes7ePmjt59F8RnnvNu
         LurLRycMAY3d7W2lZLpIQoP6qQEBXOjO5wK8OrGeC/xrmK1aIpqL1ph1fbLTdQSltWaQ
         ew1qMARQP8KvPXL72v8ZN2hGNHugJg6qRyyxbBkGeuIz0PLZrv56cUlC7CyRLCB9wy0e
         PaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEDK+MD7msFVnEXL1lXahPug1mTti/EdfAzUWZkIleA=;
        b=qGcae3t8+qLgxIYbj7z3hFwC9YBOJ7wsMVcYQ0mXyKyr+CgLh6w/mjZI6CLnRC9N6g
         jE0lpRm6QTWr3dCxzuHAA0MAB62bf/gEiWl7C3oBWR3Q0bBs+8OcPEJPaNmJdGSUd01K
         j5Z+BOB2hWbH5NyItnOK8agK+tN78Uq5BrD1Mv3ov+T6sSfhxMMytfmivsrDmCbL6vpX
         iDBHVvXrbORPAIDYcD1aNwcNmUxq2Fv/PnfAp1fgXTprhFGacHs/QAkn/o+r/B+eN73m
         ISB7nRQeGsj6tGoF0mfI9EQTRB8jA9sM2qS+MwyQgOMmTAl6EClTkSEjwaLwMyFN0Naw
         sOCg==
X-Gm-Message-State: ACrzQf0PWf1eddpleVrOaUwPsZz5kQYTVVx08a1FLn9heLf5RoqFwUye
        AFUWeUjg+9gbNmnKof766VQtk8Xkp652KA==
X-Google-Smtp-Source: AMsMyM4Wj1N0EgIJBsHzgu2M5FAw3xvHiWbx/hvrZQScF45bDkZf6CrlzVaJ87hz+W91CIYJPbXUhw==
X-Received: by 2002:a63:e40e:0:b0:46e:acf4:628c with SMTP id a14-20020a63e40e000000b0046eacf4628cmr51355693pgi.159.1667968583132;
        Tue, 08 Nov 2022 20:36:23 -0800 (PST)
Received: from localhost ([36.152.119.226])
        by smtp.gmail.com with ESMTPSA id w25-20020aa79559000000b0056b8181861esm7449084pfq.19.2022.11.08.20.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 20:36:22 -0800 (PST)
Date:   Wed, 9 Nov 2022 04:36:17 +0000
From:   Wei Gong <gongwei833x@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] pci: fix device presence detection for VFs
Message-ID: <20221109043617.GA900761@zander>
References: <20221108101209-mutt-send-email-mst@kernel.org>
 <20221108175853.GA484920@bhelgaas>
 <20221108130203-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108130203-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

O Tue, Nov 08, 2022 at 01:02:35PM -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 08, 2022 at 11:58:53AM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 08, 2022 at 10:19:07AM -0500, Michael S. Tsirkin wrote:
> > > On Tue, Nov 08, 2022 at 09:02:28AM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Nov 08, 2022 at 08:53:00AM -0600, Bjorn Helgaas wrote:
> > > > > On Wed, Oct 26, 2022 at 02:11:21AM -0400, Michael S. Tsirkin wrote:
> > > > > > virtio uses the same driver for VFs and PFs.  Accordingly,
> > > > > > pci_device_is_present is used to detect device presence. This function
> > > > > > isn't currently working properly for VFs since it attempts reading
> > > > > > device and vendor ID.
> > > > > 
> > > > > > As VFs are present if and only if PF is present,
> > > > > > just return the value for that device.
> > > > > 
> > > > > VFs are only present when the PF is present *and* the PF has VF Enable
> > > > > set.  Do you care about the possibility that VF Enable has been
> > > > > cleared?
> > 
> > I think you missed this question.
> 
> I was hoping Wei will answer that, I don't have the hardware.

In my case I don't care that VF Enable has been cleared.

> 
> > > > Can you also include a hint about how the problem manifests, and a URL
> > > > to the report if available?
> > > 
> > > Here you go:
> > > lore.kernel.org/all/20221108044819.GA861843%40zander/t.mbox.gz
> > > 
> > > is it enough to include this link or do you want me
> > > to repost copying the text from there?
> > 
> > Uh, well, OK, I guess I could dig through that and figure what what's
> > relevant.  I'd like the commit log to contain a hint of what the
> > problem looks like and some justification for why it should be
> > backported to stable.
> > 
> > I still look at Documentation/process/stable-kernel-rules.rst
> > occasionally to decide things like this, but I get the feeling that
> > it's a little out-of-date and more restrictive than current practice.
> > 
> > But I do think the "PF exists but VF disabled" situation needs to be
> > clarified somehow, too.
> > 
> > Bjorn
> 
