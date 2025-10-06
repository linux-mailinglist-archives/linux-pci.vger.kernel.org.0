Return-Path: <linux-pci+bounces-37610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D7BBDF9C
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 14:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A2B64ED48B
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55DB27D782;
	Mon,  6 Oct 2025 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="tf8mpKrI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0F627CB35;
	Mon,  6 Oct 2025 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752612; cv=none; b=i93wigzag/XPCIQZOFCDZ1lIZ4cd++kDLVk8LQR61a5AWSFdLyzqRIGFcJzTgA8WoSDGnIoJV8/FfXlsH4zJsjvo87AsHBCphK6F4Yy1JvrD0kwUecvNwXBBd6QP7yroQ43IMnW5epzY0xCLvzL+iAjCyCoTt6Vs4WpxLo687hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752612; c=relaxed/simple;
	bh=x6yPRPDpJD1ql7OMC854mk/tDZ8LbOk3qCqdy7g553g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bx2fxnuDVVdxmvEuQmn5y8LM3JiwC+/6qpQLQQ+HfSAiVdQQktEqwD7wJOS2XeaQmWxZMaUjCUKc8MYdGFB4sFjo8t2vv/LurKSSRjz8rMFw466tOPzQf/983y0FsJJ9wQ5aAbVtjp4uF//knhJ/CZawViGN5GTauxH1cl9xsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=tf8mpKrI; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759752593; x=1760357393; i=spasswolf@web.de;
	bh=XGzRVf02gTBD3S5SnDTLmspy+qED18SH6HSZJHztyKg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tf8mpKrIlsk0P07/Z01P6keU4qTA1qIVZh+B3u86TjA6TUi7ZztdT0Zi7auLq6iJ
	 PkiY5naJsaSHabM8UM+qfTvF84AbzVwT5Tg0KTKDE2plLWybpb5H78ay+v2B92TUx
	 m9VogZx4r9StwDk8Xh3z0FO4QJ5kOx38as0hwOFD4K75CtayMGIHx7ad/BMWNohIp
	 cs+uGR0tm2gkeYsJCR0IGLCugnT5D0zb2Xruv6q/YsJM1Qis1vSdflZdy6M1/HwHa
	 OWaNx3RezQrqBk1uHCnkNCuETjZYl1/4aoqps/wyedosiUT6wMaMwfow+O3Zcqry7
	 bb8/eTdmE7XOqQvBSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MWiA0-1uly8X0Xay-00YNyg; Mon, 06 Oct 2025 14:09:53 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	linux-stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [REGRESSION 04/04] Crash during resume of pcie bridge
Date: Mon,  6 Oct 2025 14:09:43 +0200
Message-ID: <20251006120944.7880-5-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251006120944.7880-1-spasswolf@web.de>
References: <20251006120944.7880-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FG1MSxGaf1Kex6prA/XwXmhc98V9DcWAHkr6vhcUabn7eKomQ6M
 gesYkAMgYq8MxGfrt1iQJBvPeWfxsI7o100GV5wBE7xGjF+cCRKsiJHtj3C6P/8ZuWW5iLt
 AtkiqZErmcitrTrye9FLx+EPsapZXpgRM8EAR2dMe8hvi020xbVqohDIm9GZ2Y3oiRtfEW0
 CQp73WNZ6vSR2GB9tFQFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q5m2nSVIEqc=;8+GFE8iwWxJYR9t4oyT8iSvBDJN
 ClKtwDTKN/0YnkYCVxczepBLDDsRrpJkz3V43hs4R3AyslJLQQvHVdQjaW4tnOJMaClxTKU9y
 Bl8cQpNWAcALVOzZp9/HA4KITFX+EB3CfrCaGKQI25qNEuSpreF2UYmUWKPk4HfIT/IvZloc4
 NQ8jqWCfyIJIQnHRaafISXrt5bvpC6uNhprY5m8hUwF6mAFKaA9aTjlY4K7HBbrHsqsxbii8k
 AToi5Z6WWyD08MfqAYcAzElMifxP/AWr6w3Tljljfup+3NlNLQz5RifwTepSFKiaJsiiNo6MA
 YVkctXA/f0lriZN63c/Cek8p8Hy6Qr6KF7JN6oQtoC0yeFZZfe29wXkocYKV14rAQ706FWteF
 4J7YT6nm17VxA6vIa3clwi4rVuWi0XSkk3e4HnoWtNYTZQYimhmhRSbgnFlE1t5PNUE+4DKJ5
 NKo8ncroZsAQg4AokN0U8hchJkpOhvscp87l5StfvcQezzYuZjcNdcktSOHB6wylIXTdtl+pJ
 DS7Ai4I680eErzLWoNh/+SmxendmKXf8ICsfJNHmvkWoYeYcocOZWMVztUIZs/MB2min9M0xz
 UNz7vNXrtDBB98O3WYN5kh/AtQF4Rk8BhEtu326ifzO6F3/ReBVaCdgSs9j4lplBWzbYAOmSG
 xMjKVoUTJLX+dDknw5psuCDt1zK8s7vrJlOhkIiUkQkDtS0eIXfSWLO4E3g3WmHkjCf3gdg6s
 VjntZz2/V1oNifU/GofEfN2KpDPwrdPiZAcqCRNVfDqc2K/zDPm8yFVmOf3xTHHTarUEax3MY
 HSmSkvt2srMxp2j8tUxoMrs8qtKftdS1o2lOXiBgG1195aFcaT0koFku1bRB14cT0suWO9VOt
 QMLFOQLZqZdUi1eJoBH57wD2nnmX03jN8HJNdGWXRfxooTx6ss+AMqWMelAmyi4Qq+TAYsjR9
 UlMkXHw3ppNBq2IgbfAjobxFIMOJUmeYX2YbU6ImHLHYvrQg+5+WkfBxbb5kPHGGogQG+JmtB
 Vz1b8iaHdXqmBWtMxoo0zPb2zAFaA4WRv66NrHT4vdOGn489da9ZO5qiOQ59utsCQBZa07bsw
 0yYzy1guwz0hU2BMSgNHehM/jpZ8K0EjojMRUJCTh98cAnMTqdCKWnNSs+D3joJThJEotizO9
 kkUVIA6P3ErHlKyGwqSqL+h28IpQ/qTdsuD1Z1pMnaRyEqisvLOzgDpyTe5kbDwfPIc8b4sDV
 9sVvGLjVB6oCqq7d5fDA9rmAKVdxu9PQvUa0Iq1LTz2vSb6qCY+ezT6oBDBZQ+21W3IWf5t4N
 prfDtdxg8LzJ83UBM73m7p2FRsxUINMx5nK0JfezUebuN45x5Pm6Vsdzm4udTqzjFCT+xJa4J
 EpmZEWTZSmhJfqXBdd+CAtj5VcaQ99BuePwnbgj+D8SJWg9Eoe7GFSlBZF56lG/2HHVZ+y7gD
 PkegV1pt/2FaWeJvGDxi55T88xJzxXi1oxl1hGwWIMRBtTdg+ekxodO5EtUKChu/iscJBR3E+
 IRCtYE9xM0p1v9tH7WojShFtrBzKyTxclr9SggujNRFjQC06kXiwagF4lyWQws44JH15BdWs8
 +O0Jt8nVQsrKA079/kYXi04w0G8OJSzjYDvyh3Hp0ohwsB9pk7Mkz0zp3vckkNKLjalVJnJkj
 2L+5zeNp7dExrwDVvvfJ3Y6tJhNuKpP7kFyaGrZr5vKVHc7bHmn9muBophMAHtGFFNLFjCPon
 2IW/s05x60VnHj/oFlvwsn/P8KzDMR1yjBcJ8FCAr6DTSK0wQ5y8QbJ08KUtfw7iZAXEjMgeP
 chGGswWe6gRy53SoaLxCCurfAQ2VyHl3XIpvxbjZ2wuNoRe82qRJG0RceVQhvLNPVs7/kFaXT
 AkAMU6SCzWylfuVQcofWlmbQZop4r3JyCgoSfMKAaxXUZB6nFwSkbyI1iRezCxVHgZyStH4tn
 EJ05pwKrdngjC4rq9WwPHc0NjdPcL9oHvCbCit2CANx3LgT59IuiHOSVSm4My6wEu9skdkwr/
 MLLKfc2cAeXMI9ZHAAbwemJXQAX0cCOOwqoF4aQ3VeXn45nTX5o4U6u+SPpsfQn0ZKXp4qIpr
 i21VnpF+MwTB13h0s8KvaJ9rSfRSebNHQsY6iMttsFHpBBkl7srd5I+KkJuyDOML5gZvMVyDy
 XGCXQxirqy/ESKF1oUebIOuh/VHc7qeoUUDlS+ZAmZ+zOvgACR/Tef04xJLZnpPwuJn4XJEzr
 0xrY5JR0QJPBuVrBuJ/L2kGD85oMEO8snLJyYz/fIS5HQHu/PbdUHXC3wWaisYNoV+QLGl63z
 aWZGpkW9XqMLl+MP8fBVaI6lOQWjU0nI+KkCS2NsBGYJV6rkI+0GLxy8ETNWKgXpeDgShfE3s
 QjQImCtE0/F8R8Vkk2BbwkuY3AtZXipej8DwIN0PkUCVNvpF8VyNWnmXlNKOXQWm8DBaUlAZd
 wyBShBAno8zVNIhaXY8+pUy4qWY3r9LpIHl/a5HpSM7BA8R2YVYesMJbLCdG2IsyGCZHLrCqV
 g7tzpt5TjTxNMVhn5AGi2sMMjFFK5l4fTFkRy2TYKqs27lOVmF+R5NGdRnQubWExPPWf08S8r
 Q0sfaCR0/GebFMZqteAoKdEuuAHM9sPyYmLYclCNFinNZ+NVh9nk/W8ZGAQLKGxsnmmDw9jJ7
 d/REoPQ1oR94lFz/bfsgY2vMJ3pUhsqXCa7JZBuTB9JUeGOil5t2VOkXckV0NbCgZEcBy1AQt
 Nm1SWBUndMhUop93AwB7eaokbrdaWlwV4lLUc+l42J4gGMaZbF+RETGFa7AkqKuF6LGlW/1Se
 8ShMnJWq7piO8+ESRo8uWM1j8JJ36wpc9wqcyNwL3NPfU08uxhbWrmlctl/oClaH3cDG6kqJW
 WjM9GzhohI/ysTdzy/opyIQZBrPKE5pKkD/MPRy/5yr/HeZOW5Zio2UdjfUoFW+OYybPWQnMp
 QNL2xkUdjVguUFtEUGGhcR1oYrU6SWkVXj1ui0rKQ2UKKzmGppK+/aJ/i/9Tvwlcmpkm91kHq
 prE+qya4dn1krA5vbqqtdUlqjU8poOGdZuXH1yqA95sYg5iZThytIWy//9NTsa6hvH9z9RcG1
 p3KVCNLjdr//mWRwE9Iff0oENoRzdn2I1OMUssSjYxy8lCRL/MWMgOFNINoIGO6caYTOktNBb
 wHJybKHP8IabszcTu/uia9v17Fvxl1n9GAcxqgoCErz9rGS0uG07dtPuAYgetk0w0WYUPgY8w
 eJADFtm7IP37geOujBHTS4pSIZ0zN4mKpvB4fDqc/Z3DxfQRLNTwC9csPB7/6D/TDwRwZnBN2
 61KOxLGzW6+tTfOgit8i9oH9ZuB8tRf7/v9hEJ0yCxhBBKKu7Fi6t2w7TYEAw+gKBbYfkRpxI
 qHG0dwWXNGoNmUHgYsvzdE7isccQToz8OkLlK934RzmqCb+G8VrZBPP+WqluhdaZwyb/EnYpV
 Wj2z2Y9c6snEtUvHV121cwCdekL097Y9IoBewnvads04Hls+6rD3DrUmdYGe1ahfKXAFmWHG6
 nAnIa8IOgePiBWSX+XWjdUMxvLSdh2tQWWp6dtVqc2Pz8wO86gomdY2dPT/Y57R3UdUUmimvx
 B5cvdEXH2YQDwYjQvOTTM+ftDliQrDwBFa4jhKu3ifI3DhKzoC0WkhJCo5x9aDbq3ftyZzl1I
 R2cY452iTUHcz4hjX3Cu/kuIYc0OTMOCWDOwnqXDof3D7ogGVPP0kxyXRCRvPYgK/z0VJxdKo
 RBSCe7Go5nWx+tticNw96nBnJFFxlG15+A2chEqx20i/U1eilJCZccWoTZE866gyf6+KHROwa
 kpB286J0CE84P2I1xA73Z6xMv9preawn7NZplmyF8/zNd16jPuoKYDHMivGvA7//ZtgzITbPi
 akw8Pp9N85T6qDhlHC/iPaNbOSWZTIheROCtcmUZ2D8db0NtE7MCptiqFhMcIyJRu8cn8mfQF
 xrr6ErdeiHm1Ek7KxG/s2j9M0ATJTF+fLGzXugiqatbcWQCLBuTm+d1i23MZ8Snw/eSgqLoGX
 U0Wz46GzWdpTOB9wWsFN+eCZB68ijXJa5aAbh1AFK2h7xgI/dOJSUDdKlGtg3v6rAxnOwY35A
 q+8rVM+1gZ+1vwq5mHIXUUG/B+xtXRRtxhIYTBXsX7JbeK6I2v7wpGbmL/O64PAkxx2EO4EJe
 M9tlDnOY8G14xeXXOxAd7iEwITAKNUd28mMvBHUv3lwnFK2z/nmcU2u7R1xZQURMuai7bVswt
 5ZHEUf8zw+GPpq5R4IaHdozgxDyZF1EWSXTPLsZf3ESrcT4OmivCoKFKaV0cFzGhysLX2M8qh
 E4PeJucUIrjCCnRp5bNkwJp3SzrCOI+GYduGsWosrm31M4pWR7t5xcZAzCdX8DCBSb8MGQQkZ
 bLas15jUJU0xtjmmR+nh3A0XHhjyWEtyDmnGFDigBmf0cSkSy1G3m35X5bihdni3goBC6HMHE
 Ws3JAbt5K6vW6fl1fmG06IIpB4iiBDTXKAEbE1XCJ7C9JK6fchXC6zBNTn18jwAm9yrbZEAid
 LcWuphJUG6ZaZcpJW1myqVr8zFlIwNyuEZ5WqzvYK/hgDAqOEj5pOn8EUlk4MbykxWuUFhWFB
 V0/bSp6orBx24a0qFo+k6bQ3XVt7aAOaDQlfPSlwTmpQ5Zi2aODtA6JFc9mjltydUyKSXtvqv
 V1XLMpm+ZEit1LXTDC2Cqz1OlQ2mTGGCq6r670AdAeVx/8RPsF8db7RjLLMoSwfSRk8MxgHTj
 ezWSUxBkhOuw3pAvWmaBdxT5IjhqCy27oSghOKsQUXn+ynisNTr8dNTXw9+wqlOwqU2awHvl5
 pvxvSOWq6n+E7ixrsL2nxzw/4ZOYkGZ3PDQb/kQNdW/SHBDvx44D4uENZ8HtNIM9srEdn8Cme
 5uD0M+T2lp7XjBT54nBCFvE4xT9hHCV6g8Jt5YX6qzBxcFkTAIHQEDhrW5Dx48Ht1pQSkzAHh
 ew3WFJ6qa0hWIQHot/Tm1BgDoGSm0Va6gKOxg5tnXcLVFNlYiIoXSdYqSPtGjCKMpkksRwDjy
 zPC+AyAhCM16GsUM5g1t/nDWukLZmyFytea1aGJcUQQWeX3VHisoJKFoP/UulGKEONmwZDfAE
 Y2F+l/gX2Rj3Mhz3U=

To further close in on the crash we'll continue testing with=20
6.17.0-rc6-next-20250917-gpudebug-00029-ge797f42363d1
which adds more dev_info()s to the critical part of rpm_resume() and remov=
es some
unneeded ones:

commit e797f42363d101b146971ec4d7e6c90bcc4064cd
Author: Bert Karwatzki <spasswolf@web.de>
Date:   Mon Oct 6 12:17:16 2025 +0200

    power: runtime: and more dev_info()s to rpm_resume()
   =20
    Signed-off-by: Bert Karwatzki <spasswolf@web.de>

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 27cce7f1b1d3..c99dac998047 100644
=2D-- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -793,12 +793,8 @@ static int rpm_resume(struct device *dev, int rpmflag=
s)
=20
  repeat:
 	if (dev->power.runtime_error) {
-		if (!strcmp(dev_name(dev), "0000:00:01.1"))
-			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		retval =3D -EINVAL;
 	} else if (dev->power.disable_depth > 0) {
-		if (!strcmp(dev_name(dev), "0000:00:01.1"))
-			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		if (dev->power.runtime_status =3D=3D RPM_ACTIVE &&
 		    dev->power.last_status =3D=3D RPM_ACTIVE)
 			retval =3D 1;
@@ -887,32 +883,22 @@ static int rpm_resume(struct device *dev, int rpmfla=
gs)
 	 * the resume will actually succeed.
 	 */
 	if (dev->power.no_callbacks && !parent && dev->parent) {
-		if (!strcmp(dev_name(dev), "0000:00:01.1"))
-			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		spin_lock_nested(&dev->parent->power.lock, SINGLE_DEPTH_NESTING);
 		if (dev->parent->power.disable_depth > 0 ||
 		    dev->parent->power.ignore_children ||
 		    dev->parent->power.runtime_status =3D=3D RPM_ACTIVE) {
-			if (!strcmp(dev_name(dev), "0000:00:01.1"))
-				dev_info(dev, "%s %d\n", __func__, __LINE__);
 			atomic_inc(&dev->parent->power.child_count);
 			spin_unlock(&dev->parent->power.lock);
 			retval =3D 1;
 			goto no_callback;	/* Assume success. */
 		}
 		spin_unlock(&dev->parent->power.lock);
-		if (!strcmp(dev_name(dev), "0000:00:01.1"))
-			dev_info(dev, "%s %d\n", __func__, __LINE__);
 	}
=20
 	/* Carry out an asynchronous or a synchronous resume. */
 	if (rpmflags & RPM_ASYNC) {
-		if (!strcmp(dev_name(dev), "0000:00:01.1"))
-			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		dev->power.request =3D RPM_REQ_RESUME;
 		if (!dev->power.request_pending) {
-			if (!strcmp(dev_name(dev), "0000:00:01.1"))
-				dev_info(dev, "%s %d\n", __func__, __LINE__);
 			dev->power.request_pending =3D true;
 			queue_work(pm_wq, &dev->power.work);
 		}
@@ -929,8 +915,11 @@ static int rpm_resume(struct device *dev, int rpmflag=
s)
 		if (!strcmp(dev_name(dev), "0000:00:01.1"))
 			dev_info(dev, "%s %d\n", __func__, __LINE__);
 		parent =3D dev->parent;
-		if (dev->power.irq_safe)
+		if (dev->power.irq_safe) {
+			if (!strcmp(dev_name(dev), "0000:00:01.1"))
+				dev_info(dev, "%s %d\n", __func__, __LINE__);
 			goto skip_parent;
+		}
=20
 		spin_unlock(&dev->power.lock);
=20
@@ -966,12 +955,22 @@ static int rpm_resume(struct device *dev, int rpmfla=
gs)
 	if (dev->power.no_callbacks)
 		goto no_callback;	/* Assume success. */
=20
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	__update_runtime_status(dev, RPM_RESUMING);
=20
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	callback =3D RPM_GET_CALLBACK(dev, runtime_resume);
=20
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d callback =3D %0x\n", __func__, __LINE__, (void *) =
callback);
 	dev_pm_disable_wake_irq_check(dev, false);
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	retval =3D rpm_callback(callback, dev);
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	if (retval) {
 		if (!strcmp(dev_name(dev), "0000:00:01.1"))
 			dev_info(dev, "%s %d\n", __func__, __LINE__);

This test is currently running (booted 13:05, 6.10.2025) and I'll expect a=
 crash
after at least 24h of runtime.

Bert Karwatzki


