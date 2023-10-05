Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7755E7BA10E
	for <lists+linux-pci@lfdr.de>; Thu,  5 Oct 2023 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237088AbjJEOnW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Oct 2023 10:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233985AbjJEOiC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Oct 2023 10:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77477D88
        for <linux-pci@vger.kernel.org>; Thu,  5 Oct 2023 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696514594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yidy6TZBy1CWG6Oo6GwAJihK7/D77PxhLMlTWyhd8wc=;
        b=Dn6SUY0uuRm5Q6OTXBbi0OoHgkgdoTA+sjrkuz+WFZOW3lHm/hBDmFPaDPDjDZ8i9DkUoS
        qIeDh1CnRYEuGfulmDU7S/mQAmVEJ+EfXanVIr5nuk6TkfW8A4q9TLyhCbNQW5LkuhnOuk
        po7kdOnZmkHLht33TF0NnJ6DaodH95c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-lR-syHIUP-i9ws4vAP-MwQ-1; Thu, 05 Oct 2023 09:02:24 -0400
X-MC-Unique: lR-syHIUP-i9ws4vAP-MwQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2775a7f3803so864831a91.1
        for <linux-pci@vger.kernel.org>; Thu, 05 Oct 2023 06:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510943; x=1697115743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yidy6TZBy1CWG6Oo6GwAJihK7/D77PxhLMlTWyhd8wc=;
        b=QD1lQfohJ0rjPRUeZEc94cVJ1gC+cjiyb29GZCSLSWKoeINC7nTKW0XKVWHDn3nUk8
         WRKzQeY0x+YH9JXTRajlpvSbvXvR746cd8WK/VyAg+YjqAWnYVEN7E7L11zEAK0pu26b
         6uWVs+1cUw98fkvNoIUIluXpa1sFerhthPKyf1zevpNx8J1FeCIzcMu/AfBMNE0PYpiY
         zVjASyZ7BZ+YaFSBKOZ18zjqcyIFM2c1BYfpLy0MZi/1GVQ1gE1enpuevNcUtingIBn9
         zhThIdhT7yfoVrdhcJ2cbqUbDzLD7m+jYWw23bIohZBJf86CUVv9eRSCsL/UVfkMciLK
         uwBQ==
X-Gm-Message-State: AOJu0YyOvs/U87obN/VfA9vPRpOInuPXXOlcSlDhZvgNJOr/Q9TYpwpM
        SmpddARqFo/sBOFpJL7x/LQbkip/3V1jtyiHEln4C9F/fwDsaYpVIRX0Dm0Ju6VPRyUzBVgpfrS
        I13mKTA9zbf7GUyWhx+0RyI21EQPmO9rmuQg=
X-Received: by 2002:a17:90b:4ad0:b0:274:a021:9383 with SMTP id mh16-20020a17090b4ad000b00274a0219383mr5102303pjb.17.1696510943641;
        Thu, 05 Oct 2023 06:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUGIakY6gmiMMg7VIrDCgG6A1oUd7mRza4EcAODeKOxvfyAvfCd+QT1JpHAONy6e0NM9gveMU8O4PPolgXz5g=
X-Received: by 2002:a17:90b:4ad0:b0:274:a021:9383 with SMTP id
 mh16-20020a17090b4ad000b00274a0219383mr5102281pjb.17.1696510943386; Thu, 05
 Oct 2023 06:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230928044233.GR3208943@black.fi.intel.com> <20230928154934.GA484133@bhelgaas>
In-Reply-To: <20230928154934.GA484133@bhelgaas>
From:   Kamil Paral <kparal@redhat.com>
Date:   Thu, 5 Oct 2023 15:01:56 +0200
Message-ID: <CA+cBOTdOVnzbXXPhWhWHDs8=n3A1ixcEg6aDVxjCdsneXySdSA@mail.gmail.com>
Subject: Re: [REGRESSION] resume with a Thunderbolt dock broke with commit
 e8b908146d44 "PCI/PM: Increase wait time after resume"
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, bhelgaas@google.com,
        chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 28, 2023 at 5:49=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> Do we know how suspend/resume works with Windows in this
> configuration?

Hello Bjorn. I'm not sure if you're asking in general or about my
laptop in particular. I don't have Windows installed, so I don't have
an easy way to test this. There used to be some "evaluation" version
of Windows that I think I could use to test it, but it would be a
considerable time investment for me (including backing up my data,
etc), and I'm currently low on spare time. So at this moment I'm
unfortunately unable to help with this question.

