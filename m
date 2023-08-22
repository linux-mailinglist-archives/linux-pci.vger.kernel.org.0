Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6861784477
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 16:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbjHVOgn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 10:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjHVOgm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 10:36:42 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F224F93;
        Tue, 22 Aug 2023 07:36:40 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D787A92009C; Tue, 22 Aug 2023 16:36:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D197C92009B;
        Tue, 22 Aug 2023 15:36:36 +0100 (BST)
Date:   Tue, 22 Aug 2023 15:36:36 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
cc:     Sanath S <sanaths2@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, Sanjay R Mehta <sanju.mehta@amd.com>
Subject: Re: [PATCH] PCI: Allocate maximum available buses to help extending
 the daisy chain
In-Reply-To: <20230818045611.GE3465@black.fi.intel.com>
Message-ID: <alpine.DEB.2.21.2308220330360.49340@angie.orcam.me.uk>
References: <20230816051923.2287912-1-Sanath.S@amd.com> <ffd5401b-400b-79e2-51f2-e6866251000f@amd.com> <20230817102430.GD3465@black.fi.intel.com> <0aa6cb16-27af-345d-7e6c-cf985290d1b4@amd.com> <20230818045611.GE3465@black.fi.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 18 Aug 2023, Mika Westerberg wrote:

> > > > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
> > > Did you get confirmation that this actually solves the issue?
> > I've tested this on my setup, it is resolving the issue.
> 
> Right, but it would be good to get confirmation from the person who
> reported the issue that this actually helps. There is nothing in the
> bugzilla whether the patch worked or not.

 If you do change the defaults, then please don't forget to update 
Documentation/admin-guide/kernel-parameters.txt in the same commit 
accordingly for `hpbussize=nn', etc.

 NB it seems a common problem with vendor firmware failing to assign a 
reasonable quantity of downstream buses for hot-plug ports.  E.g. with my 
production laptop back from 2018 a single-device ExpressCard option, such 
as a PCIe serial port works just fine with hot-plug, however if I hot-plug 
a whole bus hierarchy in an external enclosure, then the system runs out 
of buses at the first PCIe switch (unless I use `hpbussize=nn', etc.).

  Maciej
