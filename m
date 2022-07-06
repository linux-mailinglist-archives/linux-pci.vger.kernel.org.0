Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB9569347
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 22:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiGFUZs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 16:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiGFUZc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 16:25:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5B22AE19;
        Wed,  6 Jul 2022 13:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78980B81ECD;
        Wed,  6 Jul 2022 20:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D762BC3411C;
        Wed,  6 Jul 2022 20:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657139116;
        bh=wuncvhN57Sak96AraAMdXUe617s/eFjjZhDBJneKDYo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JyQTLPsY/lq5rKAezFGwTpf8zOpHXLZ10Cvvyc2axbu596miP5i9bji3ZQfNUJOSI
         7VvMp8Ceap5isb7JChzcGtuCoLW/IO20MdrNbLIIOBRbgfYdg8JBQi3Lv8FWnAXo0B
         YkmXZFjsXhOD1Ekx/1BsFkjxHSJyPyGQbZpN2a7cSh1bQNYNU+6Nmt+LVBLWh22c1D
         +tbyEtblzji6EWJtsVxPC5GlRbR5WPUu84sUxzcXSVCsBraZAjRm+uXmXqogmkdZF7
         dOXa0sPs/hsmV4WI9PskOWzRZqOZa5hWOcacloUBwxr+Lvq99Mcsxh5vPcXGpD+ll1
         WvC08RwJhbegA==
Date:   Wed, 6 Jul 2022 15:25:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Chen <lchen@ambarella.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: endpoint: Don't stop EP controller by EP function
Message-ID: <20220706202514.GA218769@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5rn3NdV63c6-22UqxBpxCNeSdog6Sr+SiZjt7K5pkKbLw@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 06, 2022 at 12:15:38PM +0900, Shunsuke Mie wrote:
> 2022年7月6日(水) 12:08 Bjorn Helgaas <helgaas@kernel.org>:
> > On Wed, Jul 06, 2022 at 11:37:29AM +0900, Shunsuke Mie wrote:
> > > 2022年7月6日(水) 7:40 Bjorn Helgaas <helgaas@kernel.org>:
> > > > On Wed, Jun 22, 2022 at 01:09:24PM +0900, Shunsuke Mie wrote:
> > > > > For multi-function endpoint device, an ep function shouldn't stop EP
> > > > > controller. Nomally the controller is stopped via configfs.
> > > >
> > > > Can you please clarify this for me?
> > > >
> > > > An endpoint function by itself wouldn't stop an endpoint controller.
> > > > I assume that some *operation* on an endpoint function currently stops
> > > > the endpoint controller, but that operation should not stop the
> > > > controller?
> > > >
> > > > I guess the operation is an "unbind" that detaches an EPF device from
> > > > an EPC device?
> > >
> > > It is likely that after all of the endpoint functions are unbound, the
> > > controller can be stopped safely, but I'm not sure if it is desired behavior
> > > for endpoint framework.
> >
> > I'm not asking about the patch itself.  I'm asking about the commit
> > log because "an EP function shouldn't stop EP controller" doesn't
> > quite make sense in English.
> I'm sorry.
> 
> > I suspect it should say something like "unbinding one endpoint
> > function of a multi-function device from the endpoint controller
> > should not stop the controller."
> Yes, it is correct and represents the commit clearly.

Thanks!  I updated the commit log to the following:

  PCI: endpoint: Don't stop controller when unbinding endpoint function

  Unbinding an endpoint function from the endpoint controller shouldn't stop
  the controller.  This is especially a problem for multi-function endpoints
  where other endpoints may still be active.

  Don't stop the controller when unbinding one of its endpoints.  Normally
  the controller is stopped via configfs.

