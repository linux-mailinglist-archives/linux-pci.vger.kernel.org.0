Return-Path: <linux-pci+bounces-1256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6331481AEAF
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 07:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955191C21FEE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 06:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A396AB3;
	Thu, 21 Dec 2023 06:16:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B951B641;
	Thu, 21 Dec 2023 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.17.2/8.17.2) with ESMTPS id 3BL6G2Zk018535
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 21 Dec 2023 16:46:04 +1030
Date: Thu, 21 Dec 2023 16:46:02 +1030
From: Jonathan Woithe <jwoithe@just42.net>
To: Igor Mammedov <imammedo@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Regression] Commit 40613da52b13 ("PCI: acpiphp: Reassign
 resources on bridge if necessary")
Message-ID: <ZYPYIpO36YE8V8hQ@marvin.atrad.com.au>
References: <ZXpaNCLiDM+Kv38H@marvin.atrad.com.au>
 <20231214143205.4ba0e11a@imammedo.users.ipa.redhat.com>
 <ZXt+BxvmG6ru63qJ@marvin.atrad.com.au>
 <ZXw4Ly/csFgl76Lj@marvin.atrad.com.au>
 <20231215143638.032028eb@imammedo.users.ipa.redhat.com>
 <ZXziuPCKNBLhbssO@marvin.atrad.com.au>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXziuPCKNBLhbssO@marvin.atrad.com.au>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Sat, Dec 16, 2023 at 10:05:22AM +1030, Jonathan Woithe wrote:
> On Fri, Dec 15, 2023 at 02:36:38PM +0100, Igor Mammedov wrote:
> > On Fri, 15 Dec 2023 21:57:43 +1030
> > Jonathan Woithe <jwoithe@just42.net> wrote:
> > > As mentioned, testing another kernel can only happen next Thursday.  If
> > > you would like other tests done let me know and I'll do them at the same
> > > time.  I have remote access to the machine, so it's possible to retrieve
> > > information from it at any time.
> > 
> > lets wait till you can get logs with dyndbg='...' (I've asked for earlier)
> > and one more test with "pci=realloc" on kernel CLI to see if that helps.
> 
> Okay.

I added the "dyndbg=" option to the 5.15.139 kernel command line and booted. 
The resulting dmesg output has been attached to bugzilla 218268.

I also tested 5.15.139 with the "pci=realloc" kernel parameter.  This was
sufficient to allow the system to boot without a GPU initialisation failure.
The dmesg output from this boot has also been attached to bugzilla 218268.

I used kernel.org's 5.15.139 for these tests because I already had it
compiled and was a little short of time.  If you'd like me to repeat the
tests with a different kernel let me know which one and I'll see what I can
do.  The Christmas break may delay this somewhat.

Regards
  jonathan

