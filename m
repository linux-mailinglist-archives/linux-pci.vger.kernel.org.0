Return-Path: <linux-pci+bounces-12906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFB196FBE7
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 21:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9142820A0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 19:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567781D1732;
	Fri,  6 Sep 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b="kpwPO5qB"
X-Original-To: linux-pci@vger.kernel.org
Received: from sonic310-20.consmr.mail.sg3.yahoo.com (sonic310-20.consmr.mail.sg3.yahoo.com [106.10.244.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B1A155C98
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.244.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650066; cv=none; b=OBhgEVF9org82yAfGVs3ROCCHrDUQT5EQBLjbYd2cW2BAIMrSReYQwnm1mBeudocNsBKRSUHIj+EkUgC3MyHzdb0BrgmpxwWqZH+nIFO7HpHdO6b72e6ZtB0AZFE3pyD52viW5WGAshGAgt0aeYehfkIC+RNdwbxeVlMv3zzamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650066; c=relaxed/simple;
	bh=91Gm+n7lHXSPobts12IqYlGj2pk5mgUHxNd/8HhLr4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFysTYo3jRFMxqf2nq8ZKhDHABBa7wSCQTMuAka2UaEm8Mzij1TaebsL72r05d0eLBTZlmbMpxCSJZbMlbBwDfBIMXFE0X2ZEcqy94U3lFVExwgBvefkfIXyR18YtxvJhuP6zeQiMnQbxP3B+UcKmWP3LcNTFoBlGZVcO4gugDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com; spf=pass smtp.mailfrom=myyahoo.com; dkim=pass (2048-bit key) header.d=myyahoo.com header.i=@myyahoo.com header.b=kpwPO5qB; arc=none smtp.client-ip=106.10.244.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=myyahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=myyahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=myyahoo.com; s=s2048; t=1725650062; bh=bePaBPxk6JxBFbhqLcL3oCLLyXL/BL88EJuncIiPuXQ=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=kpwPO5qBmF5xA4hcG8f2m8JxZQ3AiY58HLLkH03JR7KIcOgKciukINYq6+HSBkFv9bANMB1VL1s9ryCCSMNvR1RoX8ku5LdJ+bm2+n5ACzkPhrPjS+dc75Tz5Pqf+sNEZXC5k9dDfILDU0EfifWmP6AIyKnHu/RFXxQgsfNWdcXr3RGqeuuuAogh5mA/Q2DoP3bSWFqsvKg9AvFNAcceSWA1qPSg+EyyCHeIo47ZcY26FbgyJpilLa6MDmERdm0B+yGroZtLfIdHkwqMBPm63DuMxh/Dg7hqD7ph3w8K291KqOtN0mgTFL6IS6TppbeBqvNwq+TJyFuDq2Yb+KKb1A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1725650062; bh=Cf3EBg5H8TIXHQhxkAo/8OpTTK3ju7F604h4POTTjUD=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=dWk9cZGC31bFUQaqZ485rbbhZhz7CNXeg+Mgo6VoggtFYZsmVGOr5GXF9VxObgpGOB3Lv4BTzqaapVBPjP6MiRR8974Eg7HXVLrLJYmV08pq3MXhrxGlIlg6m2rhSauhbrS6a2nu7N6FlD5X1wt/q1cHrulT534YcLPMEkPCy2M4k0boJgifjBAU/E45phMVpLfezHzxcVEz1k5Z4zouZTB2aOWd2jfvY6rjdqx+WBzIo6MDCgrkv5MXMWAFwcN95krVHrlZQRk796Or0wLRF6PFzut7C9v6IfK/mzyq0CG3p1w6yMpPEMABzFKsTSsPiiwet3/AUxTZc/kirhRKZA==
X-YMail-OSG: 5E9RdvAVM1kiR7v9Rb5P_2lCSPaMrIsJy_sjMElCNa79Bd_GzVXlNOIoFccnLlC
 pXbIl1x4fStC6VsIZV8JL_i0NAiBjbqAyiL0mT_EgS4D0mCV0bED.BCkzGP6avTXCj1YFCqfRfJJ
 Ho5BIBY3CXAqmi1ohcHWB6VYIskt9cst9E7YdBhmH21D0U9n5Duu3zjIh.D5Bab9xicfQn2Cr9va
 .efecU0Dx8Cui.0goiXaa6aoPSGoB4agRh7R9AF9qMgmRH_RnHRHTOMo_X4XRWV5SuOG4_q3rBCY
 dwaxZn7u7CtUueE9_ZdTkHHN5zVKMBgRgqL5FCPUFUvht3cQMfcGmd.sqQQxReABB_Y3lXs9w_Zn
 yI61X60REsViGiGVuXDGY9aclT.XUiVxrY9TaUSY0rF0wbjO8rE3CD_M6kReMn0mDZuhSjrbuRfO
 K9W2BHxvXuHvWA2Qv8QHZu5cSOJ_x2PY1t417e68xaT8zFO407YJBf.09KcB2zIsX8Rq9z9kGWlC
 AjxNrV3.ddrWQ2QQHQfM02UBPYn5x7LVspz79regJiIx9.mjejjpHVnLJH9mc3LQCs6sG0A35C0I
 On3QGyFIc4icwS8xbHdOfMHl._Mirf5iwQqQLjtmj4AV5jlL2mUOp1Ie8ivPhy3gN7jvb9Hjdb84
 zxGYO9z7799SLBDIS9En1d1vtfipmfBaI62iUzfM45GcxR.3LBTaY8kbFbAkeRhDvsaab0CXgnF8
 faTf6SuoJExbWFlGjQJbBV_GYJDcpcop99ROSUbiQBZ9RMvYjo5HliK934efDqzd_4vBcnniSBRW
 VePd4gELSRrJZJ.axE6a3dhZTcOQpb9BbqM06nx296A6_p5WwFU1Vs9DTk9VcmpBoN5EGEmUqG3K
 GtkHd4NnuZ8DmnYqaeVA5X40p5NolqkkvFPzZdqXdwrMMVD96bwPwqA0IOEw6NB2lHxkoWMYFtRq
 vo_c5JIFHYE2ipz1XNwe1MxsEAEWd.nyxroZAVE.S4A0hcTKL5Z9Fw_Df.wlXkklsaDddEGVgATd
 hosrfiJlN7EdzKbXPXdsmPmVbqgcGS9NPGl4OqlkaphYjHFUU1v6XoA4YdqJ1qXX0UGRnD7a9K_X
 ptUg_jt8St8HJb9DAgC_o0KjbyjtOYeM2TC_.VKH2RLvoVIXhuunQOH7qD9htkR7oOAlDvjDgDSM
 dAcSmGYEKEx9LeOuW.Wu5Qsa72tpN1LRIo5HV_lSepErgAM6LOe92Vq8HPtJRA9cc1Z1cfHc.uO1
 SpRLKFV.uQyq761JsjAq5Aftcbpi6BPIUrZz00Iafn3DRgVzOEklYJ0CPHK7o9onGux67S8OQtoe
 cHUoTsvWS_vgRC0rOXF.4rz_9rTH_s9F2PiP9TtIwnXSnhMYPwG1.EJZhV5t8bSKutL2af7tcznY
 xjyCAIQ4UZUfdIwuCFixkNgh1Yz7anzkn0ecfbJZILMIBTVE0IHqM2gL3bHHa87qlzUvu_2aGi3H
 LhPktD1II4hloKLu07bJiwnUrBhbNFs_o1rqXgSjoQ3tcNZmRi8oDRh2hd2lg4ZVIsUKmIu7ARpk
 _S3iff43o5z8jUgEBicEa_rBbUl1lO_U8mrf1r_wkqFFx4PyXXXT.qkT0sgyJWtWo3U5Fm6WNSNT
 KGuoCXb6lQ6mJl6gMHXzxM63aWsox96qKISVAdGcA3WK9UNEQKfoaSr0ywcB7.dYkiRh41mxJW3l
 NNLzMoPyv5n_m1oGxFlh8gouh9WDE4on2ozO4xjNRRWEL2FrGz3ZEj_KGKB6zRyBL0Guafvckg.m
 8JsvExI.jIj7935ljAhUSdSRTu4b8sPPTgQA_1eYwhOZfT4d3VYKFJGqjO_38evxJoxAui6Oy3Sg
 s2RJ7n3tmR3U8ydz9Pn67rWCqRz3if7_1wsnPUeG7w2e_dQJ2ED8_CE7FgJGmmPGILuCepUzQw.l
 Zkbjg3PgzTae32YBz1rBNhZEzSX_h3tRnlnHsars_d3CXvt2YzXElUn4IHKQMEKNZkIEptqSfUU4
 fyw6MX8BaqRF3gMO2GrTVE8CPmLx2q5nbH9AEsYU9CXZkF1P5NEoL78SsK0nfNyam6ARy6ATsPvt
 Sdd0ReGaERV6hs4y9Li5UG72SR0noK.G8rsoM7_P1U4loWvUlx3HgITV6KJEx8dHim5TpBJmaxr1
 Hg6TiAxgHHnUepRlppCvyOtx3eYAfJsd1hU_lnYbwGU_F66AZjbi8hL54hscxbbQT5gNYzF9U9Fp
 VUTZFWHj2yWqLhgtva04nS..d1Rk7m6y2z_YGrXNlZQC7
X-Sonic-MF: <abdul.rahim@myyahoo.com>
X-Sonic-ID: 69a83071-4507-40c2-99aa-1e5d3f4f8494
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.sg3.yahoo.com with HTTP; Fri, 6 Sep 2024 19:14:22 +0000
Received: by hermes--production-sg3-fc85cddf6-lsbnm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f71780e6970a9deceff0757e8b3b42fc;
          Fri, 06 Sep 2024 19:14:17 +0000 (UTC)
Date: Sat, 7 Sep 2024 00:44:13 +0530
From: Abdul Rahim <abdul.rahim@myyahoo.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] PCI: Fixed spelling in Documentation/PCI/pci.rst
Message-ID: <u4xan54bdxf5sniwhtvrixw3b2vg4c7magey6q3rsd4ssq6ihk@xfbijuhadyw4>
References: <20240906124518.10308-1-abdul.rahim@myyahoo.com>
 <20240906164152.GA424952@bhelgaas>
 <i432epqedna43bnow5twmm7bdf7dlms54kt5xjewalf5koamks@6kn4bx5lrubz>
 <87cylgehr5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cylgehr5.fsf@trenco.lwn.net>
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On Fri, Sep 06, 2024 at 12:53:18PM GMT, Jonathan Corbet wrote:
> Abdul Rahim <abdul.rahim@myyahoo.com> writes:
> 
> > On Fri, Sep 06, 2024 at 11:41:52AM GMT, Bjorn Helgaas wrote:
> >> On Fri, Sep 06, 2024 at 06:15:18PM +0530, Abdul Rahim wrote:
> >> > Fixed spelling and edited for clarity.
> >> > 
> >> > Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> >> > ---
> >> >  Documentation/PCI/pci.rst | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > 
> >> > diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> >> > index dd7b1c0c21da..344c2c2d94f9 100644
> >> > --- a/Documentation/PCI/pci.rst
> >> > +++ b/Documentation/PCI/pci.rst
> >> > @@ -52,7 +52,7 @@ driver generally needs to perform the following initialization:
> >> >    - Enable DMA/processing engines
> >> >  
> >> >  When done using the device, and perhaps the module needs to be unloaded,
> >> > -the driver needs to take the follow steps:
> >> > +the driver needs to perform the following steps:
> >> 
> >> I don't see a spelling fix here, and personally I wouldn't bother with
> >> changing "take" to "perform" unless we have other more significant
> >> changes to make at the same time.
> >
> > - "follow" has been corrected to "following", which is more appriopriate
> > in this context.
> > - I know its trivial, but can disturb the readers flow
> > - do you want me to change the message to "Edited for clarity"
> 
> The problem is not s/follow/following/, it is the other, unrelated
> change you made that does not improve the text.  There are reasons why
> we ask people not to mix multiple changes.  If you submit just the
> "following" fix, it will surely be applied.
> 
> Thanks,
> 
> jon

Understood, will take care next time. I will resend this patch with:
"follow" -> "following", with commit message "Fixed spelling"

